From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Thu, 18 May 2017 15:12:23 +0200
Subject: [PATCH 7/8] clocksource/drivers/fttmr010: Merge Moxa into FTTMR010
In-Reply-To: <CACRpkdaWoGYh4D3D0+3mzVDTy78O2idyDmg9+U5zJc_mfn+WLQ@mail.gmail.com>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
 <20170517140542.20016-8-linus.walleij@linaro.org>
 <CACPK8XdRe8Khnj3YFoQYKpKHM-5PHTqkP8Nt+jZ=eo-FThN-aw@mail.gmail.com>
 <CACRpkdaWoGYh4D3D0+3mzVDTy78O2idyDmg9+U5zJc_mfn+WLQ@mail.gmail.com>
Message-ID: <53dc1088-41bb-f272-2aa8-f0ade762d6d5@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> As an aside, we have a pretty decent model for the Aspeed SoCs in
>> Qemu. If you want to use it to smoketest your rework:
>>
>>  $ qemu-system-arm -m 512 -M ast2500-evb -nodefaults -nographic
>> -serial stdio -kernel arch/arm/boot/zImage -dtb
>> arch/arm/boot/dts/aspeed-ast2500-evb.dtb
>>
>> I tested with Ubuntu's qemu v2.8. It looks like we have a bug when the
>> kernel tries to use the clock the way your driver works, so we will
>> look at that. It does function properly for the current upstream code.
> 
> Oh that's sweet! I'll test it if I can get it working like this.

In case you need a small ramfs, here is one :

	https://openpower.xyz/job/openbmc-build/distro=ubuntu,target=evb-ast2500/lastSuccessfulBuild/artifact/images/evb-ast2500/obmc-phosphor-initramfs-evb-ast2500.cpio.lzma

Cheers,

C. 
