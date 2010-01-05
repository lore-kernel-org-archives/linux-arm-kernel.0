From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jan 2010 09:14:11 -0800
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
	kexec, atags
In-Reply-To: <20100105113629.GB8349@gw.healthdatacare.com>
References: <20091219034151.26198.26570.stgit@localhost>
	<aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
	<20091229220705.GM3512@atomide.com>
	<20100105113629.GB8349@gw.healthdatacare.com>
Message-ID: <20100105171411.GB12378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mika Westerberg <mika.westerberg@iki.fi> [100105 03:34]:
> On Tue, Dec 29, 2009 at 02:07:05PM -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * Magnus Damm <magnus.damm@gmail.com> [091227 21:54]:
> > > Hi Tony,
> > > 
> > > On Sat, Dec 19, 2009 at 12:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > > Here are some v7 fixes, mostly to make kexec work.
> > > >
> > > > Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> > > > git repo, I can reboot my n900 in a loop reliably.
> > > 
> > > Thanks for your work on this. I previously tested kexec on ARM V6 and
> > > V7 and noticed that V7 didn't work. I revisited my V7 test after
> > > becoming aware of your patches. The single patch below unbreaks V7 on
> > > my target system.
> > > 
> > > > ? ? ?arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work
> > 
> > Cool. Thank you for fixing the kexec source :)
> > 
> > Are you seeing the occasional crc errors when uncompressing the
> > new kernel on your v7?
> > 
> > I'm seeing those maybe 1 out of 10 times on omap3430 boards unless if
> > I do an extra (and wrong) flush_cache_all after local_flush_tlb_all
> > at the end of setup_mm_for_reboot.
> 
> Hi,
> 
> I've also been playing with this patch.
> 
> One thing I noticed is that If I disable L2 cache in cpu_v7_proc_fin()
> then kexec works fine and no crc errors from decompressor (I did
> ~30 kexec boots). With L2 cache enabled, it fails almost immediately.
> 
> Tested with OMAP3430 ES3.1.

OK cool. I thought disabling the caches should also disable L2, but
looks like not then.

Regards,

Tony
