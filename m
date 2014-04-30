From: david.vrabel@citrix.com (David Vrabel)
Date: Wed, 30 Apr 2014 10:25:59 +0100
Subject: [Xen-devel] [PATCH] Xen: hibernation is x86-only at the moment
In-Reply-To: <5165529.jneGVBC5b5@wuerfel>
References: <5165529.jneGVBC5b5@wuerfel>
Message-ID: <5360C1A7.8060401@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/14 21:00, Arnd Bergmann wrote:
> In commit 603fb42a66499ab "ARM: 8011/1: ARM hibernation / suspend-to-disk",
> currently in linux-next, the ARM architecture gains support for
> hibernation (suspend-to-disk). Xen supports this in principle, but only
> has an architecture specific hypercall defined on x86, which leads
> to a build error when both hibernation and Xen support are enabled:
> 
> drivers/xen/manage.c:105:2: error: implicit declaration of function 'HYPERVISOR_suspend' [-Werror=implicit-function-declaration]
>   si->cancelled = HYPERVISOR_suspend(si->arg);
> 
> It is probably a good idea to define this hypercall on ARM as well
> and provide an implementation in the host, but until that is done,
> this patch helps disable the broken code in the Xen guest by making
> it depend on CONFIG_X86.

Since this isn't a regression in 3.15-rcX can you provide the
appropriate hypercall on ARM.  This does not require that there is an
implementation on Xen.

When the Xen implementation exists it will be easier to use if the
support already exists in Linux.

David
