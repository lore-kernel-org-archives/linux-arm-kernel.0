From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Sep 2017 22:34:44 +0200
Subject: [GIT PULL] ARM: config: aspeed: Changes for 4.14
In-Reply-To: <CACPK8Xe0C=A9_+5EHwhTMPTxd8mV5n52rC+XHLLvdSn+Lasq5A@mail.gmail.com>
References: <CACPK8XehxPjTuAq70ofmom9_DJ7LBR2C0ehO+2jGJUANTXod+A@mail.gmail.com>
 <CAK8P3a2WqMuqgOrg6JJpLJagVgWRKUgw=muC_ivzz2RguAMPjQ@mail.gmail.com>
 <CACPK8Xe0C=A9_+5EHwhTMPTxd8mV5n52rC+XHLLvdSn+Lasq5A@mail.gmail.com>
Message-ID: <CAK8P3a2j9HKQLVAaypr+L5aVvxOLR6PHQnnbJR4BF69ti09vBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 5:10 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Thu, Aug 24, 2017 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
>> For some reason, we never added a multi_v6_defconfig, but we could do that now,
>> and add the other common v6 platforms as well: bcm2835, oxnas, omap2, imx3,
>> s3c64xx and realview. (cns3xxxx, picoxcell and vt8500 are pretty much dead
>> as far as I can tell)
>
> I assumed this was because the V7 and V6 platforms can be built into
> the same kernel.
>
> We could get the same coverage by making sure all of our V6 platforms
> are enabled in multi_v7_defconfig.

Enabling CONFIG_CPU_V6 there may have noticeable overhead on v7
platforms, and it would be a bit confusing, so I'm not sure about doing
that by itself.

However, a related question would be whether we want to add options
for ARMv7VE (adding IDIV and LPAE) and ARMv8 and then using
config fragments to specialize what is currently the multi_v7_defconfig
to give us four separate configurations (v6/v7/v7ve/v8.0) with an
increasing feature set but decreasing platform support.

     Arnd
