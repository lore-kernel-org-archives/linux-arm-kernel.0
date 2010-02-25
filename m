From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 25 Feb 2010 11:36:26 -0800
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20100225193027.GA7391@elf.ucw.cz>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com> <20100119054516.GB22153@elf.ucw.cz>
	<1263914079.1951.43.camel@m0nster> <20100131084421.GG2238@elf.ucw.cz>
	<20100131092829.GJ2238@elf.ucw.cz> <1264953492.2059.5.camel@m0nster>
	<20100225193027.GA7391@elf.ucw.cz>
Message-ID: <1267126586.5439.56.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-25 at 20:30 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > (and similar error further down). This fixes it, but you probably want
> > > > to add machine_is_* to your git. (Aha, is that what you meant by
> > > > "machine types"?
> > > > 
> > > > With this patch it compiles.
> > > 
> > > Ok, it compiles, but I do not see it booting. You config has:
> > > 
> > > CONFIG_MSM_DEBUG_UART=3
> > > # CONFIG_MSM_DEBUG_UART_NONE is not set
> > > # CONFIG_MSM_DEBUG_UART1 is not set
> > > # CONFIG_MSM_DEBUG_UART2 is not set
> > > CONFIG_MSM_DEBUG_UART3=y
> > > ...
> > > CONFIG_DEBUG_LL=y
> > > CONFIG_EARLY_PRINTK=y
> > > 
> > > set, so I'd expect it to say something on the serial line... (right?
> > > Or do I still need to patch printk.c to get that?). And I see nothing
> > > :-(.
> > > 
> > > I'm using
> > > 
> > > ./fastboot -c "console=ttyMSM2 root=/dev/mmcblk0p1 rootdelay=5 fbcon=rotate:1" boot /data/l/linux-dwalker/arch/arm/boot/zImage
> > > 
> > > ...with different kernel, it works (as in "I get most of the boot on
> > > serial line; it will not actually mount root").
> > 
> > Have you seen this error?
> ...
> > /home/dwalker/linux-2.6/drivers/video/msm/msm_fb.c:24: fatal error: linux/msm_mdp.h: No such file or directory
> > compilation terminated.
> > make[4]: *** [drivers/video/msm/msm_fb.o] Error 1
> > make[3]: *** [drivers/video/msm] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [drivers/video] Error 2
> > make[1]: *** [drivers] Error 2
> > make: *** [sub-make] Error 2
> 
> Yes, framebuffer has problems.
> 
> > Even with the framebuffer off I still don't get any serial output on a
> > plain 2.6.33-rc6 .. I'm using a config that you sent me when you first
> > tested my -next tree .
> 
> 2.6.33 boots here, with attached config. I'll try -next next.

My -next tree hasn't changed much since you last looked at it .. I
wouldn't bother testing it. I might take some small fixes from that tree
to merge, but what's there is still too much of a mess to merge.

I just pushed another tree called "working-mmc" which still needs some
clean up but should have working mmc if you want to test that.

Daniel
