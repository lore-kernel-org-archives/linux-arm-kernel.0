From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Nov 2011 11:59:55 +0000
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <20111111114735.GC5114@totoro>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <20111111114147.GE12410@mudshark.cambridge.arm.com>
 <20111111114735.GC5114@totoro>
Message-ID: <20111111115955.GG12410@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 11:47:35AM +0000, Jamie Iles wrote:
> On Fri, Nov 11, 2011 at 11:41:47AM +0000, Will Deacon wrote:
> > The issue stems from the fact that we have to route the PMU interrupts to
> > the correct CPU manually (I think only MSM routes them as PPIs, which is
> > clearly the correct thing to do). To do this, we expect the IRQ resources to
> > be laid out in CPU order. In hindsight, maybe naming the resources might
> > have been a good idea, but them we'd still have to generate the names using
> > CPU numbers when iterating through the platform device.
> 
> There isn't yet a way to do naming of resources with DT, and although I 
> think there was a proposal for doing named register resources I don't 
> think this has been accepted and there wasn't anything for IRQ 
> resources...

That's good news - means I have an excuse other than laziness for not
implementing this for perf :)

Will
