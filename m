From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 16:28:38 +0200
Subject: [PATCH 11/14] ARM: LPC32xx: DTS adjustment for using pl18x
 primecell
In-Reply-To: <201206111414.14264.arnd@arndb.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-12-git-send-email-stigge@antcom.de>
 <201206111414.14264.arnd@arndb.de>
Message-ID: <4FD60096.7050603@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 04:14 PM, Arnd Bergmann wrote:
> On Monday 11 June 2012, Roland Stigge wrote:
>>                         sd at 20098000 {
>> -                               compatible = "arm,pl180", "arm,primecell";
>> +                               compatible = "arm,pl18x", "arm,primecell";
>>                                 reg = <0x20098000 0x1000>;
>>                                 interrupts = <0x0f 0>, <0x0d 0>;
>> +                               status = "disable";
>>                         };
>>  
> 
> The proper way to write this is 'status = "disabled";', with a 'd' at
> the end.

Thanks for the note!

Funnily, I always did it this way. Looks like initially, I copied from
somewhere else (wrongly). Indeed, we have lots of "disable", see also:

omap3-beagle.dts
omap4-panda.dts
omap4-sdp.dts
tegra20.dtsi
tegra30.dtsi

Roland
