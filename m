From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 12 Sep 2016 16:54:33 +0300
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <20160909091857.7a263220@ipc1.ka-ro>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
Message-ID: <cf4c3f2b-c9f1-b7ff-c5b9-5cf622957296@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On 09/09/2016 10:18 AM, Lothar Wa?mann wrote:
> Hi,
>
> On Thu, 08 Sep 2016 15:15:57 -0700 Stefan Agner wrote:
>> On 2014-10-10 07:22, Lothar Wa?mann wrote:
>>> This patch series adds support for polarity inversion to the pwm-imx
>>> driver. The patches have been tested on i.MX6, i.MX53 and with the
>>> ti-ehrpwm.c driver.
>>
>> Do you know what prevented this patchset from getting merged?
>>
> No idea.
>
>> We are looking for Polarity support in PWM for too, this is especially
>> useful for backlight control.
>>
> Actually the PWM driver may be the wrong place to achieve this. When
> the backlight driver sets the brightness to 0 to switch the backlight
> off, it will disable the PWM. This will make the PWM pin go LOW and
> thus turn the backlight to full brightness rather than off (unless there
> is an additional GPIO that controls a backlight enable pin on the LCD).
>

I've just realized that I had submitted practically the same change
(excluding iMX specifics) and about the same time in October 2014, but
my v1 is one and a half hours later than yours preceding v6 :)

Since I've subscribed to the linux-pwm right before sending my changes,
I don't have your changes in my mailbox. Would you mind to review my
v3 "pwm: support backward compatibility of DTB extending PWM args":

   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303833.html

then incorporate anything you find useful into your series and resend
v7? Or just resend the rebased v6 if nothing is found attracting?

In my turn I'll spend time to review the series and test it on iMX.

--
With best wishes,
Vladimir
