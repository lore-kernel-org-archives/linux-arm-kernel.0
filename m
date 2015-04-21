From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 15:05:43 +0100
Subject: your mail
In-Reply-To: <20150421132139.GE3996@e103592.cambridge.arm.com>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
 <20150421112420.GV12732@n2100.arm.linux.org.uk>
 <20150421125049.GW12732@n2100.arm.linux.org.uk>
 <CAKv+Gu9TkvEGLz-8K_F3jbvourWw8R-XScGSPagxbaakRXZKpg@mail.gmail.com>
 <20150421132139.GE3996@e103592.cambridge.arm.com>
Message-ID: <20150421140543.GY12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 02:21:46PM +0100, Dave P Martin wrote:
> On Tue, Apr 21, 2015 at 02:10:42PM +0100, Ard Biesheuvel wrote:
> > Yes, that is much better. It is a pity that we still can't use '| 1'
> > but the fact that you are forced to use 'adr' now probably mostly
> > eliminates the risk regarding that.
> > 
> > I did notice that are are 4 or 5 instances (commented inline) of an
> > ARM to thumb mode switch which can just as easily be implemented as
> > 'blx 1f' instead of using this badr macro (whose use we want to
> > discourage, I assume, since the address arithmetic is still slightly
> > dodgy). Do you think we should do something about that as well?
> 
> Err, probably.  That just looks like an oversight -- I think I'm
> responsible for at least some of those.
> 
> There's no good reason not to replace adr+BSYM+bx.
> 
> For switches from ARM, this could be replaced with bx <label> which
> should work just fine.  There shouldn't be any instances of this from
> Thumb, because switching instruction set is the whole point here.

Where do you get this bx <label> from?  It doesn't seem to be in
DDI0406C.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
