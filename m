From: dansharon@nanometrics.ca (Dan Sharon)
Date: Thu, 20 Jan 2011 10:33:23 -0500
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024850919E@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024850919E@dbde02.ent.ti.com>
Message-ID: <AANLkTin-xRaiwsj05h7aL3r=3nbAMDFPkjPo0gzGCbwf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

you're quite right - if 'arecord -f dat | aplay -f dat' is executed
immediately after boot, indeed I do get the same errors as you.

Thank you very much for the patches.
Regards,
/Dan

On Thu, Jan 20, 2011 at 12:05 AM, Rajashekhara, Sudhakar <
sudhakar.raj@ti.com> wrote:

> Hi Dan,
>
> Thanks for testing this patch. I'll add your Tested-by tag when I submit
> this patch.
>
> On Wed, Jan 19, 2011 at 00:32:21, Dan Sharon wrote:
> > These patches apply cleanly to 'v2.6.37'
> > 3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5
> >
> > of
> > git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git.
> >
> > The kernel was built with the 'da8xx_omapl_defconfig' from the
> omap-l1tree,
> > and 'make menuconfig' to enable ASoC (the defconfig already has
> CONFIG_REGULATOR=y,
> > CONFIG_REGULATOR_DUMMY=y, and CONFIG_REGULATOR_TPS6507X=y).
> >
> > Testing was done on a da850evm by tftp'ing the kernel into ram, and using
> the
> > SPI-flash-based rootfs from the PSP that shipped with the board.
> >
> > Using 'arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 > /tmp/arecord.cap'
> produced
> > a file of 384000 bytes (48000 x 2 x 4 bytes/sample).
> > 'arecord -r 48000 -c 2 -f S32_BE -t raw -v > /dev/null' ran flawlessly
> for several
> > hours.
> >
> > I was not able to reproduce Sudhakar's problems with 'arecord -f dat |
> aplay -f dat'.
> >
>
> Did you try the above, immediately after the da850evm boots? I am not
> facing the issue if I run arecod and aplay together after executing
> arecord or aplay individually.
>
> Thanks,
> Sudhakar
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110120/bbe43d9d/attachment-0001.html>
