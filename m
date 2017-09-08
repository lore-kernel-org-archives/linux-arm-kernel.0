From: joel@jms.id.au (Joel Stanley)
Date: Fri, 8 Sep 2017 12:40:20 +0930
Subject: [GIT PULL] ARM: config: aspeed: Changes for 4.14
In-Reply-To: <CAK8P3a2WqMuqgOrg6JJpLJagVgWRKUgw=muC_ivzz2RguAMPjQ@mail.gmail.com>
References: <CACPK8XehxPjTuAq70ofmom9_DJ7LBR2C0ehO+2jGJUANTXod+A@mail.gmail.com>
 <CAK8P3a2WqMuqgOrg6JJpLJagVgWRKUgw=muC_ivzz2RguAMPjQ@mail.gmail.com>
Message-ID: <CACPK8Xe0C=A9_+5EHwhTMPTxd8mV5n52rC+XHLLvdSn+Lasq5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:

>>  - Enable new Aspeed drivers for i2c, lpc snoop and vuart
>>  - Set VMSPLIT_2G for ast2400 platforms, required for mtd driver
>
> Pulled into next/defconfig. What's the state of the platform now? If
> it's basically
> working now, we should probably enable the config options in multi_v5_defconfig
> as well for improved testing.

It's close. We can boot upstream on hardware these days.

The final "core" driver is the clk driver that I've taken a stab at
for the ast2500. Some review of that would be appreciated:

https://patchwork.kernel.org/patch/9916635/

>
> For some reason, we never added a multi_v6_defconfig, but we could do that now,
> and add the other common v6 platforms as well: bcm2835, oxnas, omap2, imx3,
> s3c64xx and realview. (cns3xxxx, picoxcell and vt8500 are pretty much dead
> as far as I can tell)

I assumed this was because the V7 and V6 platforms can be built into
the same kernel.

We could get the same coverage by making sure all of our V6 platforms
are enabled in multi_v7_defconfig.

Cheers,

Joel
