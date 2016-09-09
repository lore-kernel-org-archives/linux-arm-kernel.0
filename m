From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 9 Sep 2016 09:18:57 +0200
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <6c896634c4d6446df0388da2c0228232@agner.ch>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
Message-ID: <20160909091857.7a263220@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 08 Sep 2016 15:15:57 -0700 Stefan Agner wrote:
> On 2014-10-10 07:22, Lothar Wa?mann wrote:
> > This patch series adds support for polarity inversion to the pwm-imx
> > driver. The patches have been tested on i.MX6, i.MX53 and with the
> > ti-ehrpwm.c driver.
> 
> Do you know what prevented this patchset from getting merged?
> 
No idea.

> We are looking for Polarity support in PWM for too, this is especially
> useful for backlight control.
> 
Actually the PWM driver may be the wrong place to achieve this. When
the backlight driver sets the brightness to 0 to switch the backlight
off, it will disable the PWM. This will make the PWM pin go LOW and
thus turn the backlight to full brightness rather than off (unless there
is an additional GPIO that controls a backlight enable pin on the LCD).


Lothar Wa?mann
