From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Aug 2018 18:33:39 +0300
Subject: [PATCH] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <20180829150942.GD22270@lunn.ch>
References: <3276b82491c1eda1e05a0e6b94560cfa451cf8d4.1535544789.git.baruch@tkos.co.il>
 <20180829141159.GB22270@lunn.ch> <8736uxxmai.fsf@tkos.co.il>
 <20180829150942.GD22270@lunn.ch>
Message-ID: <871sahxk4s.fsf@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn writes:
>> The schematics say "AP Reset Switch". So it is probably meant to be a
>> software controlled "back to default" button. Is there a suitable
>> linux,code for that?
>
> There is a reset code.

I can't find it. The only match for RESET in
include/uapi/linux/input-event-codes.h is KEY_ZOOMRESET, which is most
likely not what you meant.

>> It is not assembled here so I could not test. The schematics say SLB9670.
>
> I think the standard SPI TPM TIS driver should work for that. But if
> it is not populated, you cannot test it.
>
>> >> +			port at 5 {
>> >> +				reg = <5>;
>> >> +				label = "cpu";
>> >> +				ethernet = <&cp1_eth2>;
>> >> +			};
>> >
>> > No fixed-link? It correctly defaults to 2.5G? I've never tested that.
>> 
>> Seems to work here
>
> It would be good to test it really is using 2.5G, not 1G.
>
>> There is also a patch from Rabeeh (which I did not
>> apply while testing) to make it the default:
>> 
>>   https://github.com/SolidRun/openwrt/blob/openwrt-18.06-sr/target/linux/mvebu/patches-4.14/533-fix-88e6141-cpu-max-speed.patch
>
> Which is why i don't think it actually is using 2.5G.

I see this from phylink_mac_config():

[  511.043783] mvpp2 f4000000.ethernet eth2: phylink_mac_config: mode=fixed/2500base-x/2.5Gbps/Full adv=00000,00008200 pause=10 link=1 an=1

Is that enough for a test?

> This patch will need a little rework, but it basically O.K. Change
> mv88e6x41 to mv88e6341. We use the family name in function names.

Thanks again for reviewing this not-yet-posted patch.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
