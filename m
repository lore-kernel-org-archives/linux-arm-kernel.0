From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 10:51:30 +0800
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c
 into the db8500 Device Tree
In-Reply-To: <4FC56ABE.2020700@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
 <4FBB4782.9090101@linaro.org>
 <CACRpkdb80+4i_9JJpSu9X3biFywnFPvU-7HkZ94btz0iPL723A@mail.gmail.com>
 <4FC45598.903@linaro.org>
 <CACRpkdafqKU8fUYPMsB5Pu+NBDDV_iSXez7F3BT-To7E1Vfs2w@mail.gmail.com>
 <4FC56ABE.2020700@linaro.org>
Message-ID: <CACRpkdbY9=bNhAui+b2Tb0Q6S0n7ZVHBuPz-wYuGMKfgdQrq3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 8:33 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 30/05/12 08:09, Linus Walleij wrote:

>> So assume this one device tree gets deployed, and some poor windows
>> phone developer start scratching his head about the strange voltage
>> domain regulator for the I2C device, when in reality there is no such
>> thing, there is only an APE voltage domain regulator common for all
>> these devices.
>
> I'm more than happy to 'do the right thing', but I need to know what that is
> first.

My working assumption is that the right thing to do is delete this regulator
from the I2C driver, then refactor the (out-of-tree) runtime PM code to
fetch the voltage domain regulators, so the APE voltage domain
regulators get taken by the voltage domains instead.

I haven't tried deleting it though, plese try it and see if the domain is
still on anyway, then it's the way to proceed.

Yours,
Linus Walleij
