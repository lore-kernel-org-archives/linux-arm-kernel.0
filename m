From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Aug 2016 16:46:03 +0530
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com> <20160804210045.GD15013@gobelin>
 <m2fuqknnqk.fsf@baylibre.com> <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
Message-ID: <dd4712ba-6144-8c64-59a6-7673936af53c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 August 2016 04:39 PM, Sekhar Nori wrote:
> On Friday 05 August 2016 04:30 AM, Kevin Hilman wrote:
>> Karl Beldan <kbeldan@baylibre.com> writes:
>>
>>> On Thu, Aug 04, 2016 at 12:20:27PM -0700, Kevin Hilman wrote:
>>>> Karl Beldan <kbeldan@baylibre.com> writes:
>>>>
>>>>> This adds 2 pinctrl groups (rtscts, rxtx) for each of the 3 UARTs.
>>>>>
>>>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>>>>
>>>> Should da850-evm be updated to use the serial2_rxtx_pins also?
>>>>
>>> I could not find the EVM schematics on the net and I only have an LCDK,
>>> but according to the code it should, however I can't tell whether flow
>>> control pins are used.
>>
>> Ok, let's just leave it for now, since it's working fine.  Sekhar can
>> fix that up if he can dig up the schematics.
> 
> Looks like the flow control pins are being used for McASP also on the
> EVM. So lets leave the EVM as-is.

Rather, the EVM dts file should be updated to use serial2_rxtx_pins like
the LCDK. Right now it seems to be relying on bootloader to serial2
setup pimux correctly. I can make a patch to fix that. Or if you can do
it, that will be great too.

Regards,
Sekhar
