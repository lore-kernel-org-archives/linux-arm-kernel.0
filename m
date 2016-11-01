From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Nov 2016 15:01:08 +0530
Subject: [PATCH v2] ARM: davinci: da850: Fix pwm name matching
In-Reply-To: <1477944264-18637-1-git-send-email-david@lechnology.com>
References: <1477944264-18637-1-git-send-email-david@lechnology.com>
Message-ID: <7379b08c-acab-51a6-b5b8-eca789d10fc0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 November 2016 01:34 AM, David Lechner wrote:
> This fixes pwm name matching for DA850 familiy devices. When using device
> tree, the da850_auxdata_lookup[] table caused pwm devices to have the exact
> same name, which caused errors when trying to register the devices.
> 
> We cannot have multiple entries for the same clock in in da850_clks[], so
> we have added child clocks to the EHRPWM and ECAP LPSC clocks so that each
> PWM device will have its own clock for proper name matching.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

This looks good to me. Thanks!

I have added it to my fixes branch for further testing before sending
upstream.

Thanks,
Sekhar
