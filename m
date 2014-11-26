From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 10:00:31 +0100
Subject: [PATCH v3 4/5] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <CAAfSe-uoXOJ8=agCFuBnXhj7nBBTskQ=8_jMtv_SAjor2gfO2w@mail.gmail.com>
References: <1416917818-10506-5-git-send-email-chunyan.zhang@spreadtrum.com>
 <3490516.nCDXzA8J8x@wuerfel>
 <CAAfSe-uoXOJ8=agCFuBnXhj7nBBTskQ=8_jMtv_SAjor2gfO2w@mail.gmail.com>
Message-ID: <5825969.ZSdbLFRUel@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 10:32:35 Lyra Zhang wrote:
> 
> For now, we have only one platform(Sharkl64) based on ARM64 been submitted,
> but we're intending to add support for more our platforms based on ARM64 or
> ARM32 in the future. There are many common devices on these platforms, such
> as serial. Our idea would be that if we had a 'menuconfig ARCH_SPRD' in the
> Kconfig, these common devices only need to depend on ARCH_SPRD in the
> respective Kconfig, otherwise they may depend on a few Kconfig symbols for
> every platforms which include these common devices.
> 
> So, do you think whether we should define a menuconfig(ARCH_SPRD) in the
> Kconfig for this case ?

It sounds like your other platforms are all related, so one ARCH_SPRD
should be enough. If someone wants to build a  kernel that is only
going to run on a particular machine, they can just turn off all the
other drivers they don't want.

	Arnd
