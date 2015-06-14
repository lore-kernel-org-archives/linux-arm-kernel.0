From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 14 Jun 2015 21:39:47 +0200
Subject: how aarch32 jump to aarch64
In-Reply-To: <CADUS3okH9M-=zpeu_UH55sTT0wrPoxNzYxyT=Yzrb9NgUezgDg@mail.gmail.com>
References: <CADUS3okH9M-=zpeu_UH55sTT0wrPoxNzYxyT=Yzrb9NgUezgDg@mail.gmail.com>
Message-ID: <10952759.0QA4gdRIiH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 June 2015 23:06:49 yoma sophian wrote:
> hi all:
> as far as I know, we can use pseudo eret to let aarch64 jump to aarch32.
> But how could we let aarch32 --> aarch64?
> 

I believe the only way is to trap into a higher privilege level, e.g. from
user space to the kernel, or from kernel into hypervisor mode. If you
want to implement mode switching within one binary, you would then add
a syscall/hypercall/... that returns without switching back to aarch32.

	Arnd
