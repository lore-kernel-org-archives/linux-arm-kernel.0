From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 1 Oct 2013 12:03:51 +0800
Subject: [GIT PULL]ARM: sirf: dts fixes for 3.12-rc
In-Reply-To: <CAOesGMiQKdoq8ir0OPtWOgd1ndSxvdn8C69nDy_BC-a4AZ891g@mail.gmail.com>
References: <CAGsJ_4yfNE3NMvf9jkyaZM84i9zdEM3wm=VgFPamKT_F33Lo2A@mail.gmail.com>
 <CAOesGMiQKdoq8ir0OPtWOgd1ndSxvdn8C69nDy_BC-a4AZ891g@mail.gmail.com>
Message-ID: <CAGsJ_4ya8VyCz4vtkrHjVfpSYBYDuwohoCj7a13FAtByRyKakg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Thanks!

2013/9/30 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Sun, Sep 29, 2013 at 6:29 AM, Barry Song <21cnbao@gmail.com> wrote:
>> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>>
>>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
>> tags/dts-fixes-for-3.12
>>
>> for you to fetch changes up to 65dc961989ba0f4dc57d614a9af43c19460204dd:
>>
>>   ARM: dts: sirf: fix interrupt and dma prop of VIP for prima2 and
>> atlas6 (2013-09-29 21:08:06 +0800)
>>
>> ----------------------------------------------------------------
>> ARM: sirf: dts fixes for 3.12-rc
>>
>> A set of fixes for sirf dts for 3.12. Among them:
>>   - add missed chhifbg node in prima2 and atlas6 dts
>>   - add missed cell, cs and dma channel for SPI nodes
>>   - add missed graphics2d iobg in atlas6 dts
>>   - add missed address-cells and size-cells for prima2 I2C
>>   - add missed memcontrol-monitor node in prima2 and atlas6 dts
>
> This looks like new SoC enablement to me? Or did something break that
> used to work?

"add missed cell, cs and dma channel for SPI nodes" should break
current SPI as related codes have been in drivers/spi/spi-sirf.c.
"add missed address-cells and size-cells for prima2 I2C" should also
fix the enumeration of  i2c clients.

others can be queued for 3.13.


>
>>   - fix makefile to build atlas6-evb.dtb for ARCH_ATLAS6
>>   - fix the ranges of peri-iobrg of prima2
>>   - fix fifosize, clks, dma channels for UART
>>   - fix interrupt and dma prop of VIP for prima2 and atlas6
>
> These four look OK.
>
> I'll cherry-pick in the fixes, please queue the rest for 3.13.
>
>
> -Olof

-barry
