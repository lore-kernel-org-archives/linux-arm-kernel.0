From: sophian.yoma@gmail.com (yoma sophian)
Date: Wed, 22 Aug 2018 17:41:46 +0800
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <7e88a8c9-e44c-1548-1480-260a433d9ab4@arm.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
 <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
 <868t53pj5i.wl-marc.zyngier@arm.com>
 <CADUS3o=getrG8E+CF9PC5sdcPQwxE3r2XWfSy=H_-mYEacaLdQ@mail.gmail.com>
 <867ekmps33.wl-marc.zyngier@arm.com>
 <CADUS3okU1dCJyhfZ7E+dg1Sjb5pqFyPQjwpO0jsq+noMNPoxZg@mail.gmail.com>
 <7e88a8c9-e44c-1548-1480-260a433d9ab4@arm.com>
Message-ID: <CADUS3okCLLJgABJqOx+Zquyo7fxiu1SWNEoNYGWt2UD4NsU8CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Marc:
> >> These registers are banked on AArch32 because there is no EL3 with its
> >> own translation regime, meaning that both S and NS TTBRs have to be
> >> live at the same time for the exception to be handled.
> > so in aarch32:
> > a) the secure world(EL1_S) has the same capability as monitor mode(EL3)
> >      (Not only TTBR/VBAR are the same, the aarch32 secure world can
> > even modify SCR as well)
> > b) the monitor mode is nothing but a vector hook for SMC/FIQ/IRQ based
> > on SCR's setting.
> > right?
>
> Something like that. It is not designed as a separate exception level,
> but instead as a mole on the side, given that the S/NS split was a
> fairly late addition to the ARM architecture (it only appears in ARMv6).
thanks for ur kind and thoughtful explanation.
