From: keescook@chromium.org (Kees Cook)
Date: Tue, 3 Nov 2015 15:18:47 -0800
Subject: [PATCH v2 2/2] arm: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <20151103223904.GG8644@n2100.arm.linux.org.uk>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <1446574204-15567-2-git-send-email-dcashman@android.com>
 <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
 <20151103223904.GG8644@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jJWdZ57uMACwRBcOoU8MqPu9-pN+cp9WzyguY+G3C5qWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 2:39 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 03, 2015 at 11:19:44AM -0800, Kees Cook wrote:
>> On Tue, Nov 3, 2015 at 10:10 AM, Daniel Cashman <dcashman@android.com> wrote:
>> > From: dcashman <dcashman@google.com>
>> >
>> > arm: arch_mmap_rnd() uses a hard-code value of 8 to generate the
>> > random offset for the mmap base address.  This value represents a
>> > compromise between increased ASLR effectiveness and avoiding
>> > address-space fragmentation. Replace it with a Kconfig option, which
>> > is sensibly bounded, so that platform developers may choose where to
>> > place this compromise. Keep 8 as the minimum acceptable value.
>> >
>> > Signed-off-by: Daniel Cashman <dcashman@google.com>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> Russell, if you don't see any problems here, it might make sense not
>> to put this through the ARM patch tracker since it depends on the 1/2,
>> and I think x86 and arm64 (and possibly other arch) changes are coming
>> too.
>
> Yes, it looks sane, though I do wonder whether there should also be
> a Kconfig option to allow archtectures to specify the default, instead
> of the default always being the minimum randomisation.  I can see scope
> to safely pushing our mmap randomness default to 12, especially on 3GB
> setups, as we already have 11 bits of randomness on the sigpage and if
> enabled, 13 bits on the heap.

My thinking is that the there shouldn't be a reason to ever have a
minimum that was below the default. I have no objection with it, but
it seems needless. Frankly minimum is "0", really, so I don't think it
makes much sense to have default != arch minimum. I actually view
"arch minimum" as "known good", so if we are happy with raising the
"known good" value, that should be the new minimum.

-Kees

-- 
Kees Cook
Chrome OS Security
