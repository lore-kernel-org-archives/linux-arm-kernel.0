From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 11 Jul 2012 16:52:45 +0800
Subject: MX28EVK mainline 3.5-Patchs-3.5-rc5 sgtl5000 record not working
In-Reply-To: <20120711031446.GB14060@S2101-09.ap.freescale.net>
References: <CAHE2-smsOufHjfyjKARcwHve4cGqWeM8y7ALxcJkaqLiZBNoSw@mail.gmail.com>
 <20120711031446.GB14060@S2101-09.ap.freescale.net>
Message-ID: <20120711085244.GA22640@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:14:48AM +0800, Shawn Guo wrote:
> Copy driver maintainer Dong here.
> 
> Regards,
> Shawn
> 
> On Tue, Jul 10, 2012 at 06:09:44PM +0200, Andreas Gretler wrote:
> > Hi,
> > 
> > i've tested mainline 3.5-Patchs-3.5-rc5 for MX28EVK and it boot up and
> > work fine.
> > 
> > But I'm not able to record something. Playback works. I also test it
> > against the old 2.6.35.3 Kernel and there record works.
> > 
> > arecord -l show me this:
> > 
> > **** List of CAPTURE Hardware Devices ****
> > card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > 
> > 
> > I try record with arecord -d 2 -D hw:0,1 -f dat test.wav , but it
> > crash the Linux. No ErrMsg printed and the board stop working.
> > I have no idea what goes wrong. I put some printk message in
> > mxs-saif.c and the last message i can see before the board crash is in
> > mxs_saif_trigger() is before clk_enable is called.
> > 
> > 		/*
> > 		 * If the saif's master is not himself, we also need to enable
> > 		 * itself clk for its internal basic logic to work.
> > 		 */
> > 		if (saif != master_saif) {
> > 			clk_enable(saif->clk);
> > 			__raw_writel(BM_SAIF_CTRL_RUN,
> > 				saif->base + SAIF_CTRL + MXS_SET_ADDR);
> > 		}
> > 
> >  In alsamixer i can not toggle the capture source from Mic-In to
> > Line-in and also can't change the Headphone from DAC to Line-IN.
> > 
> > I'm not sure this is the right place to ask? I will also post ist to
> > alsa-devel at alsa-project.org.
> > Can anyone confirm the Problem? Or do/understand I something wrong
> > with record and there is no Problem?
> > 
I can see the same problem at my side.
Usually it's caused by clock issue.
I will try to fix it tomorrow when have time.

Regards
Dong Aisheng
