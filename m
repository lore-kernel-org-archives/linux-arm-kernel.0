From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Aug 2018 15:40:27 +0100
Subject: why =?UTF-8?Q?TTBR=30=5FEL=31/VBAR=5FEL=31=20not=20banked=20i?=
 =?UTF-8?Q?n=20aarch=36=34?=
In-Reply-To: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
References: <CADUS3onm_h6aq_sQP_pdtrHpbiCok3ofjwd0yTMWFpGxHWstow@mail.gmail.com>
Message-ID: <5c1fdcd956b1c73d546010add8430f79@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-08-18 11:01, yoma sophian wrote:
> hi all:
> in ARM DDI 0487C.a, it seems TBR0_EL1/VBAR_EL1 are not banked in 
> aarch64.
> (The paragraph, Accessibility,  in section G7.2.160 (TTBR0,
> Translation Table Base Register 0)
>  and section G7.2.162 (VBAR, Vector Base Address Register.)
>
> if so, will it not make any secure issue?
> suppose EL1_NS change TTBR0 to let EL1_S access wrong page table?
> thanks for your kind help in advance,

[reposting with the list on cc and with my ARM email address]

Switching between EL1_S and EL1_NS implies that EL3 is performing a 
full
context switch of the system, similar to EL2 performing a switch 
between
guests running at EL1_NS.

Hope this helps,

         M.
-- 
Fast, cheap, reliable. Pick two.
