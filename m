From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 08:09:27 +0800
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c
 into the db8500 Device Tree
In-Reply-To: <4FC45598.903@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
 <4FBB4782.9090101@linaro.org>
 <CACRpkdb80+4i_9JJpSu9X3biFywnFPvU-7HkZ94btz0iPL723A@mail.gmail.com>
 <4FC45598.903@linaro.org>
Message-ID: <CACRpkdafqKU8fUYPMsB5Pu+NBDDV_iSXez7F3BT-To7E1Vfs2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 12:50 PM, Lee Jones <lee.jones@linaro.org> wrote:
> [Me]
>> I'm told not to put DT bindings for things in place if they are
>> incorrect, since they get set in stone... and I'm told we should
>> probably remove this one regulator from the device rather.
>> I'm just uncertain.
>
> Nothing is set in stone. I'm always happy to do clean-ups and code
> corrections. :)

So assume this one device tree gets deployed, and some poor windows
phone developer start scratching his head about the strange voltage
domain regulator for the I2C device, when in reality there is no such
thing, there is only an APE voltage domain regulator common for all
these devices.

So with device trees the fit between physical reality and what we
model in the kernel needs to be as close as possible or we will
cause trouble.

That's the implications it will have unless we get it right, and that's
why I'm hesitant.

Yours,
Linus Walleij
