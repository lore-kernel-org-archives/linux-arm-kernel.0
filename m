From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 May 2013 10:01:03 +0100
Subject: [RFC PATCH 1/2] ARM: delay: print dummy values for bogomips
In-Reply-To: <alpine.LFD.2.03.1305141945160.31158@syhkavp.arg>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <1367602547-19322-2-git-send-email-will.deacon@arm.com>
 <20130506231554.GB16801@amd.pavel.ucw.cz>
 <5188B8B2.5030601@arm.com>
 <alpine.LFD.2.03.1305141547180.31158@syhkavp.arg>
 <CAL_Jsq+Q5UMGo3J+vKKCRU+w4Kj0YN0exs7UCWTEOxmFjWfo3g@mail.gmail.com>
 <alpine.LFD.2.03.1305141945160.31158@syhkavp.arg>
Message-ID: <20130515090103.GA12907@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On Wed, May 15, 2013 at 12:56:51AM +0100, Nicolas Pitre wrote:
> On Tue, 14 May 2013, Rob Herring wrote:
> > On Tue, May 14, 2013 at 2:54 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > Waitaminute... Didn't you just claim this would be an ABI break?
> > >
> > > So if no application can be found, where is the ABI breakage?
> > 
> > lscpu
> > 
> > But that is already "broken" on ARM because x86 uses "bogomips" and
> > ARM uses "BogoMIPS". 
> 
> So basically it won't be any more broken if the field disappears 
> entirely, right?

It's not these sort of tools I was worried about. I was thinking about the
possibility of badly written parsers which want some other field from
cpuinfo, but use the bogomips line for context. Do these applications exist?
No idea.

My second (less stupid) version of the patch prints "not reported". I'd be
happy to remove the line altogether if people get behind the decision though.
In fact, I just tried it and at least my linaro filesystem seems happy
enough.

Will
