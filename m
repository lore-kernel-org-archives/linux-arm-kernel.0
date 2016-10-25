From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 11:37:18 +0200
Subject: [PATCH/RFT v2 02/17] ARM: davinci: da8xx: Add CFGCHIP syscon
 platform declaration.
In-Reply-To: <7f9efe9d-0912-e10a-3e45-24c5d2b455ab@ti.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-3-ahaslam@baylibre.com>
 <7f9efe9d-0912-e10a-3e45-24c5d2b455ab@ti.com>
Message-ID: <CAKXjFTOVuWRL+yuk6sARa2PAd6j-V4Ej5AmPGz7F7JXKidvJrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekar,

On Tue, Oct 25, 2016 at 10:10 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>> From: David Lechner <david@lechnology.com>
>>
>> The CFGCHIP registers are used by a number of devices, so using a syscon
>> device to share them. The first consumer of this will by the phy-da8xx-usb
>> driver.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> [Axel: minor fix: change id to -1]
>
> Can you please clarify this change? There could be other syscon devices
> on the chip for other common registers. Why use the singular device-id?
>

in the case of non DT boot, the phy driver is looking for "syscon" :

d_phy->regmap = syscon_regmap_lookup_by_pdevname("syscon");

if we register the syscon driver with id = 0, the actual name of the syscon
device will be "syscon.0" and the phy driver will fail to probe, because
the strncmp match in the syscon driver (syscon_match_pdevname)
will fail.

should i change the phy driver instead?


Regards,
Axel.



>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>
> Thanks,
> Sekhar
>
