From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Apr 2016 21:31:32 +0200
Subject: [PATCH] clk: sunxi: Accept a greater rate when setting a parent
 clock
In-Reply-To: <20160414201428.0c89d3b943db543c3ab08740@free.fr>
References: <20160310081658.B749246B@mail.free-electrons.com>
 <20160321072546.GT30977@lukather>
 <20160321092549.4e6245e4f02839e29aeb86a9@free.fr>
 <56FC3BEB.8030106@elopez.com.ar> <20160414172400.GR4005@lukather>
 <20160414201428.0c89d3b943db543c3ab08740@free.fr>
Message-ID: <20160414193132.GT4005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 14, 2016 at 08:14:28PM +0200, Jean-Francois Moine wrote:
> On Thu, 14 Apr 2016 19:24:00 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > >> That being said, we had a similar discussion for SPI around a month
> > > >> ago where we wanted a rate strictly lower than the requested one. I
> > > >> guess it's time to add a flag to tell how you want to round.
> > > > 
> > > > You are right, I just removed half of the constraint, but I still wonder
> > > > why does this sequence introduced by the commit 862b728387aef3a37
> > > > (clk: sunxi: factors: automatic reparenting support) do
> > > > 	"provide the fastest rate <= rate"
> > > > instead of
> > > > 	"provide the closest rate" ?
> > > > 
> > > > Emilio?
> > > 
> > > Overclocking components is usually not a good default in my opinion. I
> > > don't recall at the moment if there was some other justification apart
> > > from playing it safe.
> > 
> > Yeah, I'd agree, it should be the exception rather than the norm. In
> > some cases that are very timings sensitive (audio or video), we
> > probably want to enforce something as close as possible to the
> > expected rate, even if it trips above the rate.
> > 
> > For all the other, I'd prefer to keep the current behaviour.
> 
> OK, then, as I have no solution for this clock, there will be no audio
> 44.1KHz from the H3...

You have not read me. I already suggested in the quote above to add a
flag to tell how we should round the clock rate, the default remaining
to round it down.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/524b3ef2/attachment.sig>
