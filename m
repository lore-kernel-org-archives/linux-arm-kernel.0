From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Sep 2014 10:57:25 +0100
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <CAD=FV=W_d=S-N-hguLsH+pf3kT1XqQNMMqGZ4o2wnpWZB9T70g@mail.gmail.com>
References: <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
 <CAD=FV=VjN6Xam-nRRcxvOoN-gokU6DbGVjoPXN_fkTJssH1RWA@mail.gmail.com>
 <20140828093505.GC14650@leverpostej>
 <CAD=FV=UwfP0x-bswbtV_eUvpKeOSNnsVVLTE3VHguyhm_jiSug@mail.gmail.com>
 <20140908135436.GC22717@arm.com>
 <CAD=FV=Up=+zNneY-behnkFbhupi50_f5R=ECgJQeqGV5kz5d2g@mail.gmail.com>
 <20140910173401.GG1710@arm.com>
 <CAD=FV=WJpP1aAo-r9bnUQg5xarGQYo8pROvyh0a5dt+m1OOn4g@mail.gmail.com>
 <20140910184652.GP1710@arm.com>
 <CAD=FV=W_d=S-N-hguLsH+pf3kT1XqQNMMqGZ4o2wnpWZB9T70g@mail.gmail.com>
Message-ID: <20140911095725.GC5045@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 08:50:16PM +0100, Doug Anderson wrote:
> On Wed, Sep 10, 2014 at 11:46 AM, Will Deacon <will.deacon@arm.com> wrote:
> > If `where we're at' is trying to boot an ARMv7 product, then you can boot in
> > secure svc and lose virtualisation support. Looking forward to ARMv8, this
> > isn't going to work, so I'd encourage you to start thinking about getting
> > a working bootloader as a requirement.
> 
> Yup, definitely on the same page now.  With everyone working on this
> I'd imagine that there will be some nice standards worked out by the
> time real ARMv8 is ready to ship?
> 
> ...so would you say that you're in support of landing the patch to
> allow physical counters?  I know Olof has Acked the patch above, but
> it's nice if there's general agreement that it's OK.

I'm in favour of fixing the regression, yes. What I didn't understand from
the patch is where arch_timer_use_virtual is set to false for your machine,
as we need to be careful not to regress arm64 (the vdso uses the virtual
counter there).

Will
