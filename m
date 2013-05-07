From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 7 May 2013 16:58:23 +0100
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <5189234D.3040208@codeaurora.org>
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
 <CAFEAcA9jBSpN2p9ZaU+_gX41Ke3nvpSKVrWV8Rioy_ioadKCgg@mail.gmail.com>
 <5189234D.3040208@codeaurora.org>
Message-ID: <CAFEAcA-eSB=_UT0-L7o=2o6JGv0WkXZv5UPxPVqLRxjUZQegFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2013 16:52, Christopher Covington <cov@codeaurora.org> wrote:
> On 05/07/2013 08:19 AM, Peter Maydell wrote:
>> Well, at the moment EARLY_PRINTK is hardcoded to
>> "use some specific UART or equivalent selected at
>> compile time". So the equivalent presumably would
>> be to hard-compile "use virtio-console", but then
>> how does that code know where the virtio-console
>> is in the address space?
>
> arm64 uses a kernel argument.

This mixes up "information that the user provides to the
kernel" (ie configuration) with "information that QEMU or
kvmtool should provide to the kernel" (ie hardware
description), and would require QEMU/kvmtool to parse
the user's commandline tool to figure out if they
needed to override it or edit it (or alternatively,
would require the user to know internal details of
QEMU/kvmtool's address map for the guest). I think it
would be nicer to keep them separate.

thanks
-- PMM
