From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jun 2016 10:10:37 +0200
Subject: [Query]set clk rate must operate its coordinated clock
In-Reply-To: <20160311165152.4103.82090@quark.deferred.io>
References: <20160309152420.20de187a@xhacker>
 <20160311165152.4103.82090@quark.deferred.io>
Message-ID: <2738343.ekabfXD0fs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Am Freitag, 11. M?rz 2016, 08:51:52 schrieb Michael Turquette:
> Quoting Jisheng Zhang (2016-03-08 23:24:20)
> > I have the following clk case which I dunno the elegant solution:
> > 
> > 
> > cpuclk have two parents: cpupll and refclk. When set the cpuclk freq, we
> > have to set its parent's freq, I.E cpupll freq. But before changing the
> > cpupll's freq, we should set its refclk as its parent firstly.
> > 
> > AFAIK, this is a common case, I have seen such requirement in rockchip,
> > samsung clk driver. They solve this by notifier, but as pointed out by
> > Michael in
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351565.ht
> > ml
> > 
> > "This is also a hack and it points towards some missing infrastructure in
> > the clock framework."
> > 
> > I also don't like the notifier solution, I believe the elegant solution
> > could be using the coordinated clock infrastructure. So what's the status
> > of this infrastructure? I can test, and I can even add some code to make
> > it be ready to be merged if you guide me ;)
> 
> Thanks for the email. I hope to finish that feature before ELC. I have
> Cc'd Pi-Cheng Chen from Mediatek who is also interested in coordinated
> clock rates.

pulling this up again, did this materialize yet? :-)

Because it looks like on Rockchip we're getting yet another clock that needs 
special handling (set_rate needs to go through the trusted-firmware, while 
reading stays the same) which might profit from that as well.


Heiko
