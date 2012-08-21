From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 Aug 2012 12:05:15 -0600
Subject: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
In-Reply-To: <20120821163805.GW7995@opensource.wolfsonmicro.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
 <20120821163805.GW7995@opensource.wolfsonmicro.com>
Message-ID: <5033CDDB.808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2012 10:38 AM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 09:48:21AM -0600, Stephen Warren wrote:
> 
>> This .dtsi file adds a node for every single regulator within
>> the TPS65910, which in turn means that of_regulator_match() will
>> find a node for every regulator, and in turn every regulator will
>> be registered. On some boards, not all of those regulators will
>> be used, and hence we don't want all of them to be registered.
> 
> This isn't the general view for the regualtor API - we generally
> want all regulators to be registered in order to allow us to see
> what's going on with things even if we've not figured them out from
> software.

Oh, I said the above specifically because when I added the LDO
configuration for the regulators that weren't used to the Tegra .dts
files, you told me to remove it, based on the comment I put in there
that they weren't used on the board.
