From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 7 May 2013 13:19:46 +0100
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <87txmfo0rl.fsf@rustcorp.com.au>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
 <87obcyc9sh.fsf@rustcorp.com.au>
 <336C59AA-D5D7-472E-A8DA-EEB413DD6C68@suse.de>
 <CAAHg+Hj0tySbzUGnoFE9ybVYP291B-i8-Ck1EkwD57t8yG5wwg@mail.gmail.com>
 <C52CCDD4-D8FB-4AD6-B83D-3B5251A7A0F5@suse.de>
 <87sj27xxjr.fsf@rustcorp.com.au>
 <CAFEAcA9h8iSYfTBtf6n+Vk5sDtBR2yB2oafRxikHoWbKt0VRUw@mail.gmail.com>
 <87ip2wr8tp.fsf@rustcorp.com.au>
 <CAFEAcA_=BTXVdkN0WmajxVSjbDrmxc5z65hCbxr=7TqJVsE9EA@mail.gmail.com>
 <87txmfo0rl.fsf@rustcorp.com.au>
Message-ID: <CAFEAcA9jBSpN2p9ZaU+_gX41Ke3nvpSKVrWV8Rioy_ioadKCgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2013 05:46, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> That all looks like sensible QEMU implementation possibilities
>> but it seems to be a bit of a non-sequitur from "how do we
>> tell the kernel to actually use this?"
>
> You enable the feature in the virtio console device, and a kernel
> compiled with EARLY_PRINTK will use it?

Well, at the moment EARLY_PRINTK is hardcoded to
"use some specific UART or equivalent selected at
compile time". So the equivalent presumably would
be to hard-compile "use virtio-console", but then
how does that code know where the virtio-console
is in the address space?

-- PMM
