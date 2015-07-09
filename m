From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 09 Jul 2015 11:46:04 -0500
Subject: Build failure on ARM64 for Linux 4.2-rc1 was: Linux 4.2-rc1
In-Reply-To: <559BCC8A.1030708@redhat.com>
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>
 <559BCC8A.1030708@redhat.com>
Message-ID: <559EA54C.4060807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2015 07:56 AM, Mark Langsdorf wrote:
> On 07/05/2015 03:22 PM, Linus Torvalds wrote:
>> It's Sunday, two weeks have passed, and the merge window is closed. I
>> just pushed out the tag to the git trees, and tar-balls and patches
>> should be mirroring out too.
>
> I'm seeing a build regression on arm64 for tools/perf.
>
> On linux-4.1, it builds fine.
>
> On linux-4.2-rc1, it dies with this relevant message (skipping the
> missing defines, etc):
>
> /home/mlangsdorf/tmp/linux-4.2/include/linux/preempt.h: At top level:
> /home/mlangsdorf/tmp/linux-4.2/include/linux/preempt.h:64:25: fatal
> error: asm/preempt.h: No such file or directory
>   #include <asm/preempt.h>
>
> On both versions, arch/arm64/include/generated/asm/preempt.h
> exists. I'm guessing something changed in the build system so
> that's its not being picked up for 4.2-rc1 but I'm not sure where
> to look.

Hi Peter,

I did a git bisect and it looks like the faulty patch is
d72da4a4d973d8a0a0d3c97e7cdebf287fbe3a99, "rbtree: Make lockless
searches non-fatal". I can't see why it causes my builds to fail,
but if I revert that patch and the related series, then I can
build the kernel and build tools/perf successfully.

Any insight into a less intensive way of fixing my build would
be appreciated.

--Mark Langsdorf
