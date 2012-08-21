From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 14:52:43 +0200
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <502D622A.1030104@wwwdotorg.org>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120816033006.GA11999@shlinux2.ap.freescale.net>
 <502D622A.1030104@wwwdotorg.org>
Message-ID: <CACRpkdZghkK8eCVdzEm2bQizVq=U-Zg90i43vD9YMkS+2WxVNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 11:12 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/15/2012 09:30 PM, Dong Aisheng wrote:

>> For example, the pin_config_get/pin_config_set API in
>> include/linux/pinctrl/consumer.h can not work for such pins.
>
> Hmmm. Given we support all pin mux/config options from the mapping
> table, I'd question whether that API should even exist any more...

If there are no in-kernel users we can delete it. But I can surely see
things like PCI lab boards etc wanting to have full control over pins
from userspace, just like they can hammer GPIO's on/off today
from userspace (i.e. embedded SoCs is not the only use case)
so I wouldn't rule it out. I think this use case is quite real for
automatic control, robotics, factory lines... those guys do use GPIO
sysfs like that already today.

>> It looks like not a big issue currently since i did not see any client driver
>> using this API.
>> But i'm not sure if we may have this requirement in the future.
>> For example, is it possible that pinctrl subsystem may support configure pins
>> via sysfs dynamically?
>
> I can't comment on sysfs specifically, but I believe it would be
> generally true that a pin that isn't know to the pinctrl subsystem can't
> be manipulated in any way.

sysfs over my dead body ... but exposing pin names to userspace is
another thing, and might be interesting, in case we want to just
sort of list all pins on the system from some command line tool or
HW-info control panel. But that requires designing the userspace
device interface first, so no need to haste.

Yours,
Linus Walleij
