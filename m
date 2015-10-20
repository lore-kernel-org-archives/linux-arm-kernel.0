From: ppajuel@gmail.com (Pau Pajuel)
Date: Tue, 20 Oct 2015 12:34:11 +0200
Subject: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
In-Reply-To: <20151019145052.GB21839@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
 <20151016145707.GU10113@atomide.com>
 <CAMVEqEkoXoE1wgT8p5BNW7TAjz5Xtcvx7gXvk7rbdQXg8bXpzg@mail.gmail.com>
 <20151019145052.GB21839@atomide.com>
Message-ID: <CAMVEqEmDoQvnVfQXF9QvtyjPe2RRGe1wf=6=VifGPcSOKLcnbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,
2015-10-19 16:50 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> * Pau Pajuel <ppajuel@gmail.com> [151019 06:40]:
>> Hi Tony,
>> 2015-10-16 16:57 GMT+02:00 Tony Lindgren <tony@atomide.com>:
>> > >
>> > > So far I've tested that basic things work, such as serial, USB
>> > > Ethernet, HDMI and WLAN.
>
> Also mSATA works too BTW.
>
>> I am testing your patch without succes. Which u-boot version are you using?
>
> I'm using the isee git tree u-boot with the following enabled in the
> omap5_igep0050.h:
>
> #define IGEPv5_MEMORY_4G
> #define CONFIG_SUPPORT_RAW_INITRD
> #define CONFIG_ENV_IS_IN_FAT
> #define FAT_ENV_INTERFACE               "mmc"
> #define FAT_ENV_DEVICE                  1
> #define FAT_ENV_PART                    1
> #define FAT_ENV_FILE                    "uboot.env"
> #define CONFIG_FAT_WRITE
>
> The CONFIG_SUPPORT_RAW_INITRD is needed to support raw initramfs instead of
> using mkimage on it for bootz command. I don't think these changes should
> affect booting though.
>
>> Do you apply config changes into omap2plus_defconfig
>
> Looks like I only enabled CONFIG_USB_NET_SMSC75XX.
>
>> Here is my setup and log: http://pastebin.com/j51ugRvK
>
> My guess is that you need to play with initrd_high etc, try doing something
> like this in u-boot:
>
> setenv fdtaddr 80a00000
> setenv loadaddr 80c00000
> setenv rdaddr 81400000
> setenv fdt_high 8c000000
> setenv initrd_high ffffffff
Setting the above environment variables works for me
>
> And see if that helps?
>
> BTW, we really need to use initramfs based booting on these for NFS to
> avoid having to compile all the USB into the kernel. Well at least for
> the mainline omap2plus_defconfig.
>
> Regards,
>
> Tony

Cheers!

Pau
