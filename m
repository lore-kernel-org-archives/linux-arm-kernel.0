From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 04 Jul 2018 15:20:05 +0100
Subject: panic kexec broken on ARM64?
In-Reply-To: <a2796dc8-2f0f-468f-0c9f-ec296f3b302a@suse.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com>
 <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com>
 <a2796dc8-2f0f-468f-0c9f-ec296f3b302a@suse.com>
Message-ID: <864lhfytey.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jul 2018 15:08:38 +0100,
Matthias Brugger <mbrugger@suse.com> wrote:
> On 03/07/18 10:58, Marc Zyngier wrote:
> > I've pushed 3 patches on a branch[1]. It is mostly untested, but it
> > should allow the above RPi3 disaster to cope with kexec.
> > 
> > 	M.
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/root-irqchip
> > 
> 
> I threw the kernel on my RPi3+ model but I wasn't able to start the crash
> kernel. Unfortunately I don't have a JTAG adapter to check if it hangs for the
> same reason.

Have you annotated the RPi3 root irq_chip structure so that the arm64
kexec code knows that this is the root interrupt controller? I've only
done so on the GIC drivers.

      M.

-- 
Jazz is not dead, it just smell funny.
