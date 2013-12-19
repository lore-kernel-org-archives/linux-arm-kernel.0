From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Dec 2013 18:04:20 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
In-Reply-To: <20131218005326.GE18992@verge.net.au>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
 <52AEFF56.5010602@cogentembedded.com>
 <52AF8D57.7010705@cogentembedded.com>
 <20131217003107.GF27171@verge.net.au>
 <CAMuHMdV7y7GFrswa+f7ui8LSXj723_i5P6gBAG5ZOoMDP5LWyA@mail.gmail.com>
 <20131218005326.GE18992@verge.net.au>
Message-ID: <20131219090420.GD12239@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 09:53:26AM +0900, Simon Horman wrote:
> On Tue, Dec 17, 2013 at 11:10:15AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 17, 2013 at 1:31 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Tue, Dec 17, 2013 at 02:31:35AM +0300, Sergei Shtylyov wrote:
> > >> On 12/16/2013 04:25 PM, I wrote:
> > >> >>The koelsch board uses has an SH ethernet controller which uses a Micrel
> > >> >>phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> > >> >>Micrel-specific phy driver rather than relying on the generic phy driver.
> > >>
> > >> >    Frankly speaking, I'm seeing no advantages to doing that.
> > >>
> > >>    Although wait, Geert has reported the absence of Rx FIFO overflow
> > >> messages with this PHY driver, IIRC.
> > 
> > I spoke too soon: apparently the statistical relevance of my reporting was
> > too low. I still see them from time to time, but I think less than before (no
> > numbers available).
> > 
> > >> >>Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >>
> > >> >    Analogous changes are needed for BOCK-W and Lager boards since they all
> > >> >use the same KSZ8041RNLI PHY chip. I was going to submit such changes with the
> > >> >PHY IRQ patches but since no IRQ is generated still, this got delayed...
> > >>
> > >>    Only I was going to do it via defconfigs...
> > >
> > > That was my initial approach too. However I have been convinced
> > > that Kconfig is a better way forwards.
> > 
> > Kconfig has the advantage that the minimal defconfigs will be smaller, so
> > less churn there.
> > However, it does mean you cannot disable the option anymore via your .config.
> > 
> > In this case it's a bit difficult to decide, as sh_eth will work both
> > with and without
> > the specific PHY-driver.
> > 
> > If no users want to disable it, I'd go for Kconfig.
> 
> It is indeed a tricky choice. But I think we should try going for Kconfig.

I have decided to queue this up.
