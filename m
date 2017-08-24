From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 13:09:25 +0200
Subject: [GIT PULL] ARM: config: aspeed: Changes for 4.14
In-Reply-To: <CACPK8XehxPjTuAq70ofmom9_DJ7LBR2C0ehO+2jGJUANTXod+A@mail.gmail.com>
References: <CACPK8XehxPjTuAq70ofmom9_DJ7LBR2C0ehO+2jGJUANTXod+A@mail.gmail.com>
Message-ID: <CAK8P3a2WqMuqgOrg6JJpLJagVgWRKUgw=muC_ivzz2RguAMPjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
> Hi Arnd and Olof,
>
> Here's two Aspeed defconifg changes for 4.14.
>
> This is a bit later than I planned, sorry about that. These changes
> have been kicking around for a while now so they areb well tested.

Ok.

> for you to fetch changes up to 652213cd1081017e2139d57b6c7871670e41bf0b:
>
>   ARM: config: aspeed: Add I2C, VUART, LPC Snoop (2017-08-23 16:04:42 +0930)
>
> ----------------------------------------------------------------
> Aspeed defconfig updates for 4.14
>
>  - Enable new Aspeed drivers for i2c, lpc snoop and vuart
>  - Set VMSPLIT_2G for ast2400 platforms, required for mtd driver

Pulled into next/defconfig. What's the state of the platform now? If
it's basically
working now, we should probably enable the config options in multi_v5_defconfig
as well for improved testing.

For some reason, we never added a multi_v6_defconfig, but we could do that now,
and add the other common v6 platforms as well: bcm2835, oxnas, omap2, imx3,
s3c64xx and realview. (cns3xxxx, picoxcell and vt8500 are pretty much dead
as far as I can tell)

       Arnd
