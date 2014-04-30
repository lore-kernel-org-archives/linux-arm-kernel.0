From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 30 Apr 2014 09:57:59 +0200
Subject: [PATCH] Xen: hibernation is x86-only at the moment
In-Reply-To: <5165529.jneGVBC5b5@wuerfel>
References: <5165529.jneGVBC5b5@wuerfel>
Message-ID: <20140430075759.GA5899@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-04-29 22:00:53, Arnd Bergmann wrote:
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

You should better do the dependency in Kconfig.

This way, you'll have to update two places each time new architecture
is supported...

Thanks,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
