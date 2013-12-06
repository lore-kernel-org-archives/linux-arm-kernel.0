From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 6 Dec 2013 11:35:24 +0530
Subject: [PATCH 2/4] ARM: tegra: add pinmux controller to tegra124.dtsi
In-Reply-To: <52A10A13.2020608@wwwdotorg.org>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
 <1386241070-4350-3-git-send-email-ldewangan@nvidia.com>
 <52A10932.1040903@wwwdotorg.org> <52A10A13.2020608@wwwdotorg.org>
Message-ID: <52A16924.6040902@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 04:49 AM, Stephen Warren wrote:
> On 12/05/2013 04:16 PM, Stephen Warren wrote:
>> On 12/05/2013 03:57 AM, Laxman Dewangan wrote:
>>> The tegra124 pinmux controller is identical to tegra114 with
>>> removing some of existing pins from T114 and adding new pins.
>> I already sent this patch.
> Oh, I do notice one difference between the two patches:
>
> Mine:
>
>> +		reg = <0x70000868 0x148>,	/* Pad control registers */
>> +		      <0x70003000 0x40c>;	/* Mux registers */
> Yours:
>
>> +		reg = <0x70000868 0x164		/* Pad control registers */
>> +		       0x70003000 0x434>;	/* PinMux registers */
> Are the increase register lengths in your patch correct? If so, I guess
> I'll drop my patch and replace it with yours if you fix up the unit address.
Yes, the last entry of the bank 0 and 1 are:
DRV_PINGROUP(ao4,   0x9c8,  2,  3,  4,  12,  7,  20,  7,  28,  2, 30,  
2,  Y),
and
PINGROUP(dp_hpd_pff0,           DP,             RSVD2, RSVD3,          
RSVD4,          DP,             0x3430,  N,  N,  N),
