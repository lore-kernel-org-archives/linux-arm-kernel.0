From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 4 Apr 2013 04:39:05 +0000
Subject: [PATCH v3 0/3] Platform support for EHRPWM & ECAP devices in
 DAVINCI.
In-Reply-To: <515A983D.8040907@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <515A983D.8040907@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAA7C39@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 14:05:09, Nori, Sekhar wrote:
> On 3/25/2013 1:19 PM, Philip Avinash wrote:
> > Add platform support for EHRPWM and ECAP by providing clock nodes and
> > device tree nodes.
> > This series depends on [1] and [2] and is available for testing at [3].
> > Tested for back light support in da850 EVM with EHRPWM PWM device.
> > 
> > [1] http://gitorious.org/linux-davinci/linux-davinci/trees/davinci-for-v3.9/dt-2
> > [2] https://gitorious.org/linux-pwm/linux-pwm/trees/for-next
> > [3] https://github.com/avinashphilip/am335x_linux/tree/davinci-for-v3.9_soc_pwm
> > 
> > Note:
> > DT support for EHRPWM backlight has not been added in da850-evm.dts as there is
> > conflicting pin-mux requirement with SPI flash.
> 
> Can you check if this is really true even in newer boards (have a look
> at the latest schematics)? I remember this used to be a problem in very
> early versions but was fixed later.

On looking schematics, panel has three power controls LCD_BACKLIGHT_PWR, LCD_PANEL_PWR,
LCD_PWM0. On latest schematic, LCD_PWM0 is connected to ECAP instance 2. So backlight
can control through ECAP2 (not conflicting with SPI1 cs0). Still for controlling
backlight, require support for LCD_BACKLIGHT_PWR & LCD_PANEL_PWR. These signals
to be controlled by GPIO 2[8] & GPIO 2[15]. In release platform callbacks used
to control GPIO functionality. But with DT support, I have to check how platform
callbacks can be used.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
