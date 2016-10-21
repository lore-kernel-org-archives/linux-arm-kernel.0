From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Oct 2016 15:23:39 +0530
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <f6a0f61e-9d78-3df1-8e41-435eb47a1f00@ti.com>
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <2278105.geKhb8xoNC@avalon> <7h8ttj6jqo.fsf@baylibre.com>
 <1867292.F3aGJTmS2t@avalon> <7h8tti6c95.fsf@baylibre.com>
 <f6a0f61e-9d78-3df1-8e41-435eb47a1f00@ti.com>
Message-ID: <278cac52-020f-da2f-54d7-e68d3b71eb65@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 October 2016 02:55 PM, Tomi Valkeinen wrote:
> On 20/10/16 22:39, Kevin Hilman wrote:
> 
>> However, after our discussion on IRC, we'll respin this without the DT
>> bindings at all.  Next version will just use static configuration data
>> in the drivers/bus driver based on SoC compatible string, since for the
>> use-cases I'm aware of, the settings are boot-time only.
> 
> If it's static boot time config, why not do it in the u-boot?

Hardware initialization dependencies with boot-loader are tough to track
and debug. The bootloader thats currently ships with the board may not
have these settings, for example. This forces everyone to update their
bootloader when shifting to mainline kernel.

Thanks,
Sekhar
