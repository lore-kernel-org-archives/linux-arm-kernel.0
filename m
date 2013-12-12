From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 21:43:20 +0100
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <52A7AC4A.8010504@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-4-git-send-email-syin@broadcom.com>
 <CAEPRUYqfpdp1GqxBgx-q=hyvQDe4uyi6okzHPW2QmfmPG_Z3NQ@mail.gmail.com>
 <525FFA40.9050901@wwwdotorg.org>
 <CAEPRUYq5DA982AqAmrUpsb3qc30VaFBawaXKTp2pcDvdbM-S1g@mail.gmail.com>
 <52A7AC4A.8010504@broadcom.com>
Message-ID: <CACRpkdYYQFqT0kfpdkAGYKAZMGmfqE55BBk+P6bDC1wxcExQhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 1:05 AM, Sherman Yin <syin@broadcom.com> wrote:

> I was just trying to move "select PINCTRL" to a defconfig as Christian
> suggested.  However, CONFIG_PINCTRL is not selectable by a defconfig file
> (the option will be gone by the time .config is generated), even though
> PINCTRL has no dependency.  Also, this option is not visible in menuconfig.
>
> I found that by adding a string after "bool" in the PINCTRL config
> definition (see diff below), CONFIG_PINCTRL will be selectable in a
> defconfig file and this option will also be visible in menuconfig.
>
> Was this intentional or is this a bug?  To address Christian's comment, I'll
> need to add the following patch.

This was intentional.

Pin control was considered an intrinsic of specific embedded systems
and not to be broadcasted to anyone running menuconfig.

But if you really need this, we can discuss it.

Yours,
Linus Walleij
