From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Aug 2018 09:13:32 +0100
Subject: why TTBR0_EL1/VBAR_EL1 not banked in aarch64
In-Reply-To: <CADUS3okU1dCJyhfZ7E+dg1Sjb5pqFyPQjwpO0jsq+noMNPoxZg@mail.gmail.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
 <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
 <CADUS3okx-PWqP3N2rCy-WdCMy38oT3sUqtxOqYgbOCbAMmCEpg@mail.gmail.com>
 <CADUS3okzvPoe_xBNDOPtc+kx=0D=r+Rsh2zXM+vOuGaBiuje3w@mail.gmail.com>
 <868t53pj5i.wl-marc.zyngier@arm.com>
 <CADUS3o=getrG8E+CF9PC5sdcPQwxE3r2XWfSy=H_-mYEacaLdQ@mail.gmail.com>
 <867ekmps33.wl-marc.zyngier@arm.com>
 <CADUS3okU1dCJyhfZ7E+dg1Sjb5pqFyPQjwpO0jsq+noMNPoxZg@mail.gmail.com>
Message-ID: <7e88a8c9-e44c-1548-1480-260a433d9ab4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/18 08:55, yoma sophian wrote:
> hi Marc
>>> Why aarch64 not just follow aarch32's design for banking TTBR0_EL1
>>> and VBAR_EL1?  ( that will saving time on context switching between
>>> S and NS right?)
>>
>> These registers are banked on AArch32 because there is no EL3 with its
>> own translation regime, meaning that both S and NS TTBRs have to be
>> live at the same time for the exception to be handled.
> so in aarch32:
> a) the secure world(EL1_S) has the same capability as monitor mode(EL3)
>      (Not only TTBR/VBAR are the same, the aarch32 secure world can
> even modify SCR as well)
> b) the monitor mode is nothing but a vector hook for SMC/FIQ/IRQ based
> on SCR's setting.
> right?

Something like that. It is not designed as a separate exception level,
but instead as a mole on the side, given that the S/NS split was a
fairly late addition to the ARM architecture (it only appears in ARMv6).

	M.
-- 
Jazz is not dead. It just smells funny...
