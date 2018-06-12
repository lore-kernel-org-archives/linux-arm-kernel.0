From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 16:58:34 -0500
Subject: [U-Boot] [RFC PATCH 0/2] ARM: v7: Enable basic framework for
 supporting bits for CVE-2017-5715
In-Reply-To: <20180612214049.GA17671@n2100.armlinux.org.uk>
References: <20180125214559.27570-1-nm@ti.com>
 <CAOMZO5CcEf=EhFWknKmCXXLJPOgx=65jLH+X1OAGkg5VxBGVew@mail.gmail.com>
 <CAGo_u6qyf1Z+zSG-17TYRDPzG8V_0_-nk1F15HB4tPyT9rbUYQ@mail.gmail.com>
 <20180612214049.GA17671@n2100.armlinux.org.uk>
Message-ID: <20180612215834.wrnfrb57ed3uxexa@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:40-20180612, Russell King - ARM Linux wrote:
[...]
> > I started respinning the series, while there is definitely a use of
> > implementing in u-boot,
> > I am starting to wonder if we should also be doing this in kernel.
> 
> How does the kernel set the bit when the kernel is running in non-secure
> mode, when the ACTLR is read-only in that mode?

For OMAP5/DRA7 SMP systems, I just posted a patch that seems to resolve
it:
https://patchwork.kernel.org/patch/10461273/

This'd be similar in implementation to ARM erratum 801819 workaround
that needs two pieces (u-boot + kernel). I am not really worried about
OMAP5/DRA7 since they should'nt loose context in Low power modes.
Other SoCs need to be aware of the constraints.

/me wishes PSCI was a standard during ARMv7, but it was'nt... So
legacy v7 SoCs have implementations that are kind of different (even
smc calling conventions vary).

-- 
Regards,
Nishanth Menon
