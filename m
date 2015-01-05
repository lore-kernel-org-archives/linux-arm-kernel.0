From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 Jan 2015 20:36:56 -0500
Subject: [PATCH v3] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <20141209122919.GR821@e106497-lin.cambridge.arm.com>
References: <1417437909-20923-1-git-send-email-Liviu.Dudau@arm.com>
 <20141209122919.GR821@e106497-lin.cambridge.arm.com>
Message-ID: <20150105013656.GA3486@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 12:29:19PM +0000, Liviu Dudau wrote:
> On Mon, Dec 01, 2014 at 12:45:09PM +0000, Liviu Dudau wrote:
> > During a recent cleanup of the arm64 DTs it has become clear that
> > the handling of PPIs in xxxx_set_type() is incorrect. The ARM TRMs
> > for GICv2 and later allow for "implementation defined" support for
> > setting the edge or level type of the PPI interrupts and don't restrict
> > the activation level of the signal. Current ARM implementations
> > do restrict the PPI level type to IRQ_TYPE_LEVEL_LOW, but licensees
> > of the IP can decide to shoot themselves in the foot at any time.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> > 
> > Made a stupid mistake in v2 and got my bit test confused with logical test.
> 
> Gentle ping!
> 
> Any comments here? Russell, are you OK with this approach?

Now that the holidays are over, I'd like to get some feedback from Marc
at a minimum...

thx,

Jason.
