From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 6 Dec 2011 08:29:43 -0000
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <20111205233621.GH14542@n2100.arm.linux.org.uk>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
 <4EDD3E5E.6050106@gmail.com> <alpine.LFD.2.02.1112051707520.2357@xanadu.home>
 <20111205233621.GH14542@n2100.arm.linux.org.uk>
Message-ID: <000101ccb3f1$34cbbf40$9e633dc0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----

> depends on !ARCH_REALVIEW || !SPARSEMEM

> No, it's correct.  None of you are understanding the logic.

> And this clearly shows that if we have realview _and_ sparsemem
> enabled,
> then we don't want P2V patching in place.

In which case wouldn't it be clearer if it was written as:

depends on !(ARCH_REALVIEW && SPARSEMEM)

Colin
