From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Fri, 4 Dec 2015 15:39:35 +0100
Subject: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP
 WiFi init
In-Reply-To: <20151203192719.GZ23396@atomide.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
 <20151203181624.GW23396@atomide.com>
 <566089E1.7050805@osg.samsung.com>
 <20151203192719.GZ23396@atomide.com>
Message-ID: <CAFqH_536_sG7fju=u39aMKmzXt8KDCxU1-dFM03H060zbh5qxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-03 20:27 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> * Javier Martinez Canillas <javier@osg.samsung.com> [151203 10:29]:
>> Hello Tony,
>>
>> On 12/03/2015 03:16 PM, Tony Lindgren wrote:
>> > * Javier Martinez Canillas <javier@osg.samsung.com> [151203 10:03]:
>> >> Hello,
>> >>
>> >> This series converts the IGEPv2 (IGEP0020) and IGEP COM Module (IGEP0030)
>> >> Device Tree to use the MMC power sequence provider to initialize the SDIO
>> >> WiFi chip instead of using fake fixed regulators to just toggle the Reset
>> >> and Power pins in the chip.
>> >>
>> >> The patches were tested on an DM3730 IGEPv2 board but the IGEP COM Module
>> >> is the same with regard to the SDIO WiFi so it should be safe to land too.
>> >>
>> >> The IGEPv2 Rev.F and the IGEP COM Module Rev.G DTS were not converted due
>> >> using a different WiFi chip (wlcore instead of libertas) than the one in
>> >> the board I've access to test so I preferred to leave those untouched.
>> >
>> > Do you have some solution for the start-up latency issue?
>> >
>>
>> No, I don't and that's one of the reasons why I didn't want to touch the
>> DTS that have the wlcore chip.
>>
>> The omap3-igep0020-rev-f.dts and omap3-igep0030-rev-g.dts don't have a
>> startup-delay-us property in the regulator for the WLAN_EN pin as is
>> the case for the IGEPv5 DTS but I don't know if those DTS are just wrong.
>
> OK
>
>> The DTS for the igep0020 and igep0030 that have the libertas chip,
>> did have a startup-delay-us for the WIFI_PDN but using the GPIOs
>> for RESET_N_W and WIFI_PDN in the mmc-pwrseq-simple reset-gpios is
>> enough to make the SDIO chip reset, be enumerated and WiFi to work
>> correctly so I don't know if that is really needed or is just a bad
>> description in the DTS.
>
> Hmm OK.
>
>> Since is working for the boards with the libertas chip, I preferred
>> to remove the DTS hack but left the boards with wlcore chip since
>> you said the startup-delay-us is needed there (but probably we should
>> add to the regulators in the boards that don't have it then).
>
> OK
>
> Thanks,
>
> Tony

I guess will be interesting cc'ing the ISEE people. Added Agusti and Pau.

Thanks,
    Enric
