From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 7 May 2013 13:56:16 +0100
Subject: [Xen-devel] [PATCH RFC v2 2/4] arm: introduce CONFIG_PARAVIRT
 and pv_time_ops
In-Reply-To: <alpine.DEB.2.02.1305071301040.4147@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305061532310.4756@kaball.uk.xensource.com>
 <1367851878-21629-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <1367918609.26321.43.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1305071301040.4147@kaball.uk.xensource.com>
Message-ID: <1367931376.26321.117.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-07 at 13:15 +0100, Stefano Stabellini wrote:
> On Tue, 7 May 2013, Ian Campbell wrote:
> > On Mon, 2013-05-06 at 15:51 +0100, Stefano Stabellini wrote:
> > > Introduce CONFIG_PARAVIRT on ARM.
> > 
> > What about PARAVIRT_TIME_ACCOUNTING? I'm not sure what it is but it
> > looks like a more lightweight version of pv stolen time?
>  
> PARAVIRT_TIME_ACCOUNTING selects PARAVIRT on x86 :-)

Ah, that's maybe what confused me.

TBH its not at all clear to me what distinction the core code is trying
to make with those two options, but do we not also want/need
PARAVIRT_TIME_ACCOUNTING? Having reread the help text it seems to be
some sort of "more accurate" accounting?

> > I think it would be a worthwhile change to refactor the stolen time
> > handling out from under the rather wide reaching umbrella of the x86
> > PARAVIRT option. (assuming PARAVIRT_TIME_ACCOUNTING isn't already that)
> 
> Actually PARAVIRT doesn't mean much in common code, the only thing it
> covers is stolen time.
> What I mean to say is that just because we are introducing something
> called "PARAVIRT" on ARM, it doesn't mean that it has to come with all
> sort of baggage.

I was more concerned with perceived baggage than actual trunks full of
skeletons.

Ian.
