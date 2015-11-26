From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Nov 2015 12:39:30 -0800
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151126090739.GD14190@pali>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali>
Message-ID: <20151126203930.GW2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151126 01:08]:
> On Wednesday 25 November 2015 20:19:21 Frank Rowand wrote:
> > > Or populate /proc/atags only for the ones that need it from machine
> > > specific init_early?
> > 
> > This is circling back to the first comment from Russell King where
> > he suggested a legacy file for the N900 which calls save_atags():
> > 
> >     Are the ATAGs at a fixed address on the N900?  Can that be handled in
> >     some kind of legacy file for the N900 which calls save_atags() on it, so
> >     we don't end up introducing yet more stuff that we have to maintain into
> >     the distant future?  If not, what about copying a known working atag
> >     structure into a legacy file for the N900?
> > 
> > It seems to me that patches 1, 2, 4, and 5 could be replaced by this
> > approach.
> 
> Hi Frank, in this case I will ask my question again: It is possible to
> read atags from that legacy file. And if yes how? I was not thinking
> about this approach because somebody in past wrote that this is not
> possible...

Just to explore options.. How about make a minimal device driver that
just loads the atags blob from /lib/firmware and then shows it in
/proc/atags? Of course some checking on the atags should be done by
the driver..

That would work as long as the kernel no longer needs it.

Regards,

Tony
