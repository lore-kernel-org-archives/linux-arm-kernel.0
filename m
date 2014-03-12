From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Mar 2014 19:59:52 +0100
Subject: [PATCH v2 1/3] ata: ahci_st: Provide DT bindings for ST's SATA
 implementation
In-Reply-To: <20140312171452.GE22450@lee--X1>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <7613177.7hd4IoKUr4@wuerfel> <20140312171452.GE22450@lee--X1>
Message-ID: <5284929.ZWl2X8pt1x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014 17:14:52 Lee Jones wrote:
> > > > > +This binding describes a SATA device.
> > > > > +
> > > > > +Required properties:
> > > > > + - compatible         : Must be "st,ahci"
> > > > 
> > > > Is there not a more specific name? This is awfully generic.
> > > 
> > > There isn't one. ST only have one AHCI driver. The driver is named as
> > > generically.
> > 
> > If it is this generic, can't you use the completely generic
> > ahci-platform driver and add a "generic-ahci" compatible string
> > to that?
> 
> It pretty much does. The only 'special' functionality we handle in
> the driver are resets and configuring the OOB. However, both are
> required.

The reset handling should be easy to add to the generic driver
usign as an optional property if I'm not mistaken.

What is OOB?

	Arnd
