From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Nov 2016 12:28:24 +0000
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <7aba95bdf0d562f3c9640d533c33e1ca@codeaurora.org>
References: <20161123191539.GF2799@io.lakedaemon.net>
 <20161123195120.GE14217@n2100.armlinux.org.uk>
 <20161123205917.GI2799@io.lakedaemon.net>
 <20161123211745.GF14217@n2100.armlinux.org.uk>
 <20161123214053.GJ2799@io.lakedaemon.net>
 <aaba8b1e30dd4c22be52e50befb202b2@aptaiexm02f.ap.qualcomm.com>
 <7aba95bdf0d562f3c9640d533c33e1ca@codeaurora.org>
Message-ID: <20161124122824.GL2799@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 02:06:57PM +0800, miaoqing at codeaurora.org wrote:
> 
> >>Okay, so i was 0, so running UP probably isn't going to help.  r7 is
> >>also spec_priv->rfs_chan_spec_scan.
> >>
> >>So, I think the question is... how is this NULL - and has it always
> >>been NULL...
> >
> >The problem appears to be that ath_cmn_process_fft() isn't called that
> >often.  When it is, it crashes in ath_cmn_is_fft_buf_full() because
> >spec_priv->rfs_chan_spec_scan is NULL when ATH9K_DEBUGFS=n. :-(
> >
> >I'm running with ATH9K_DEBUGFS=y now.  If it goes a couple of days
> >without crashing, I'll gin up a patch.
> >
> 
> A similar patch was applied to ath-next branch:
> https://patchwork.kernel.org/patch/9431163/.

Hmm.  Ok, I'm giving it a spin on my board with SMP=y, ATH9K_DEBUGFS=n
(so the only change from known crashing is the patch) and we'll see how
it goes.

Honestly, though, I think the real problem is when kernels are built
without ATH9K_DEBUGFS.  Did the reporter of the crash say if that was
enabled on his system or not?

I'm concerned that there may be other code lurking that secretly depends
on ATH9K_DEBUGFS being enabled.

thx,

Jason.
