From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 5 Apr 2015 15:00:45 +0200
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
In-Reply-To: <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <20150403183942.GV10805@atomide.com>
 <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
Message-ID: <20150405130045.GB9186@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 02:21:48PM -0500, Robert Nelson wrote:
> >> And yes, for armhf userland one gets random oopses at least on the
> >> Nokia N900. AFAIK this is not true for all ARMv7 processors
> >> (especially non omaps), though.
> >>
> >> > http://www.spinics.net/lists/linux-omap/msg108511.html
> >> >
> >> > See also 5c86c5339c56 ("ARM: omap2plus_defconfig: Enable ARM erratum
> >> > 430973 for omap3").
> >>
> >> For me the random oopses occur without this config flag and are
> >> fixed by it. The workaround is not very suitable for multi platform
> >> kernels, though, since its enabled also for unaffected platforms.
> >>
> >> As far as I can see the CONFIG_ARM_ERRATA_430973 flag is checked
> >> in proc-v7.S and in proc-v7-2level.S. I think the first file is
> >> irrelevant, since it can be fixed later (see workaround in
> >> nokia_n900_legacy_init in pdata-quirks.c).
> >
> > Yes so it seems, and the bootloaders should really set it. It's
> > also disabled for multiplatform builds.
> 
> These are now done in u-boot as of: v2015.04-rc4
> 
> http://git.denx.de/?p=u-boot.git;a=commit;h=c6f90e1418a84fe5fa463b38403bd1845cb6a59c

Seems like "include/configs/nokia_rx51.h" has been forgotten. Note,
that the kernel must still be able to enable the bit itself (in case
NOLO is used without u-boot).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150405/d4fc848a/attachment.sig>
