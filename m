From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 24 Jun 2013 16:43:05 +0100
Subject: [Suggestion] arch: arm64: xen: "ln -s" the paravirt.h from
 arm.
In-Reply-To: <51C81A39.5060909@asianux.com>
References: <51C53C06.7050205@asianux.com> <51C81115.4070803@asianux.com>
 <51C81A39.5060909@asianux.com>
Message-ID: <alpine.DEB.2.02.1306241639260.4782@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Jun 2013, Chen Gang wrote:
> Hello Maintainers:
> 
> if 'CONFIG_XEN'
> 
>   CC      arch/arm64/xen/../../arm/xen/enlighten.o
> arch/arm64/xen/../../arm/xen/enlighten.c:19:26: fatal error: asm/paravirt.h: No such file or directory
> 
> The related .config file for next-20130624 is in attachment.
> 
> 
> If "ln -s ../../../arm/include/asm/paravirt.h paravirt.h", it can pass
> compiling, but I do not know how to make a patch for it ("ln -s ..."),
> Do we have another more suitable ways for it (or another fixing ways) ?
> 
> Welcome any suggestions or completions.

The problem is caused by:

commit 3a885582a366caf868b0782041c44854ff4c3568
Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date:   Wed May 29 10:56:34 2013 +0000

    xen/arm: account for stolen ticks

that is in my tree for linux-next (even though I have not received any
replies from the ARM maintainers so I don't know when and if it is going
to go upstream).

I think that the best thing to do would be to add a couple of ifdef
CONFIG_PARAVIRT in arch/arm/xen/enlighten.c. I'll add them to my tree.
