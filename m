From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Feb 2014 14:07:53 +0100
Subject: [PATCH 0/3] ARM: dts: Fixes for Overo/Tobi against 3.14-rc1
In-Reply-To: <87d2j0rwv8.fsf@paris.lan>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
 <87d2j0rwv8.fsf@paris.lan>
Message-ID: <52FA20A9.2060702@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/06/2014 06:09 PM, Kevin Hilman wrote:
> Florian Vaussard <florian.vaussard@epfl.ch> writes:
> 
>> OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc1 [1].
>> This series fixes this, by moving model-agnostic DT into a common dtsi file,
>> and creating model-specific DT files:
>>
>> - omap3-overo-tobi.dts -> older OMAP35xx Overo
>> - omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo
>>
>> People will have to use the right Overo / expansion board combination.
>>
>> (Patch 2 in an unrelated fix that was waiting in my queue.)
>>
>> omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
>> tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
>> mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
>> a missing errata.
> 
> And I tested with my 35xx/Overo with omap3-overo-tobi.dts and my
> 37xx/Overo STORM with omap3-overo-storm-tobi.dts and they're both
> working.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Tony, with your ack, I can apply these directly to arm-soc/fixes.
> 
> Florian, thanks for the fixes.
> 

This issue is still present in 3.14-rc2.

Shall I send a v2, including the suggestion of Nishanth, against 3.14-rc2?

Regards,
Florian
