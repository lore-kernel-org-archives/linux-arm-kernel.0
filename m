From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 16:52:55 +0200
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <1369750864.2939.1.camel@hornet>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <CACRpkdaQfaPQdJ1SDN--JDqcrXs8p6=FaDN+4KtKZF6nLtOvvw@mail.gmail.com>
 <1369750864.2939.1.camel@hornet>
Message-ID: <3950519.8yj1SQodNQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013 15:21:04 Pawel Moll wrote:
> On Tue, 2013-05-28 at 15:16 +0100, Linus Walleij wrote:
> > On Tue, May 28, 2013 at 12:54 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> > > On Mon, 2013-05-27 at 11:32 +0100, Arnd Bergmann wrote:
> > >> b) add a new KMS driver for this hardware that can be used as an
> > >> alternative to the existing one and that works with DT.
> > >
> > > There are people working on this, just trying to jump through some legal
> > > hoops to post a RFC. Once this is done we'll be in an interesting
> > > position of two amba_bus drivers "competing" for the same amba_bus
> > > device, which I'm not sure how to deal with right now...
> > 
> > Make them mutually exclusive in Kconfig?
> 
> Certainly an option.
> 
> I wouldn't mind having both compiled as modules and loading one or the
> other, but it wouldn't fly with "=y"...

It's a bit ugly but I think you can express that in Kconfig like this:

config FB_ARMCLCD
        tristate "ARM PrimeCell PL110 support"
        depends on FB && ARM && ARM_AMBA
	depends on KMS_ARMCLCD != 'y'
	depends on 'm' if KMS_ARMCLCD

	Arnd
