From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Aug 2015 10:55:37 -0700
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.3
In-Reply-To: <20150818201416.GA4732@localhost>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
 <20150818201416.GA4732@localhost>
Message-ID: <CAOesGMg_TocMprCDQK69CTLtnyiyf4hn_hEzWoEhdKsXH3OuBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Aug 18, 2015 at 1:14 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Aug 12, 2015 at 12:42:29AM +0800, Shawn Guo wrote:
>> Hi arm-soc maintainers,
>>
>> This is the i.MX SoC changes for 4.3.  There are some input and rtc
>> changes, because they are applied as a series.  Subsystem maintainers
>> have ACKed these changes, so it should be fine to send them via arm-soc
>> tree.
>
> In some of these cases, may I ask why? For example, the RTC changes look
> like they could just go in through the driver tree -- adding DT support to
> a driver can definitely do so (and the DT changes to plumb up the device can go
> through your DT branch).
>
>> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>>
>>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.3
>>
>> for you to fetch changes up to 8a0fa1843638c5078e6606114ed8bdf9ea56fab1:
>>
>>   rtc: snvs: select option REGMAP_MMIO (2015-08-11 23:04:47 +0800)
>
> I've merged this, and we can merge acked drivers in the future too if needed,
> but ideally only where it's needed.

It looks like these changes broke ARM allmodconfig:

arch/arm/mach-imx/built-in.o: In function `ksz8081_phy_fixup':
:(.text+0x8bcc): undefined reference to `mdiobus_write'
:(.text+0x8bf0): undefined reference to `mdiobus_write'
:(.text+0x8c28): undefined reference to `mdiobus_write'
:(.text+0x8c4c): undefined reference to `mdiobus_write'
arch/arm/mach-imx/built-in.o: In function `imx6ul_init_machine':
:(.init.text+0xa714): undefined reference to `phy_register_fixup_for_uid'

Whole output is at:

http://arm-soc.lixom.net/buildlogs/arm-soc/v4.2-rc2-861-gdb5c5fd/buildall.arm.allmodconfig.log.failed

Please send an incremental fix (or I can drop this branch if you need
more time).

Thanks!


-Olof
