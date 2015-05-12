From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 12 May 2015 22:31:11 +0200
Subject: [PATCH RFC 0/2] stmmac: stand alone platform drivers
In-Reply-To: <5948526.xNXlKiLpxq@wuerfel>
References: <1431022765-30715-1-git-send-email-manabian@gmail.com>
 <5987007.lq0DjS0tE0@wuerfel>
 <CAGhQ9Vx0DQf-HcqEiohFLrBJPBe5qYjLgXiH3qGx85fAruh8UQ@mail.gmail.com>
 <5948526.xNXlKiLpxq@wuerfel>
Message-ID: <CAGhQ9Vxx+uLx=EDdHJog3G4RXE-1MJf=Ra2h1TAtaXQtmms_UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2015 at 21:49, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 May 2015 19:20:45 Joachim Eastwood wrote:
>>
>> I have now created a generic dt dwmac driver which contain all compat
>> strings that doesn't have any match data. As long as this driver is
>> linked last this works for my built-in drivers configuration. I am not
>> able to test using modules because of my very limited rootfs. This is
>> a Cortex-M system after all.
>>
>> I also converted all the other DT dwmac drivers and the entire patch
>> set can be found on:
>> https://github.com/manabian/linux-lpc
>>
>> After I have done some more cleanups and added proper commit messages
>> I will put them on netdev again.
>>
>>
>
> Yes, this looks really nice (with the cleanup bits that are obviously
> missing applied), thanks a lot!
>
> We should probably try to keep existing defconfig files working,
> which could be done e.g. like
>
>  config DWMAC_ROCKCHIP
>         tristate "Rockchip dwmac support"
> +       default ARCH_ROCKCHIP
>         depends on OF
>         select MFD_SYSCON
>
> so that any configuration that currently has ARCH_ROCKCHIP and DW_MAC
> enabled ends up with DWMAC_ROCKCHIP enabled as well.

Ah, yes, indeed. I will add a default statement in the Kconfig of the
converted drivers.

regards,
Joachim Eastwood
