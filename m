From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:35:56 +0100
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
Message-ID: <4FD6FF6C.6040500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 22:01, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now the AB8500 has its own IRQ domain
>
> But that does not appear until patch 8 in this series? Are the patches in
> the wrong order? Or does this need rewording?
>
>> it needs to be initialised earlier
>> in the boot sequence. As the AB8500 relies on the DB8500 PRCMU we need to
>> reflect this change for the PRCMU driver too.
>
> Hm what shall we do when we run out of initlevels? I think this was the
> kind of thing that deferred probe should solve. Usually changing this kind
> of thing has side effects so I'm a bit hesitant.

Ah yes, I remember now. The IRQ domain needs to be in place _before_ the 
Device Tree is parsed by the Open Firmware subsystem. If it's not the 
error "no irq domain found" is triggered and the IRQs are never mapped.

I'd be happy to take a second opinion, but I believe this (and the other 
core_initcall patch) is required.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
