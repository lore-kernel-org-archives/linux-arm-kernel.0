From: broonie@sirena.org.uk (Mark Brown)
Date: Tue, 22 Sep 2009 14:56:00 -0700
Subject: [PATCH 2/3] regulator: add 88PM8607 PMIC driver
In-Reply-To: <f17812d70909221113iae6fa0ew8fa19a658cf90a1e@mail.gmail.com>
References: <771cded00909070210o7d19b0a2mda910bd2d6150e7@mail.gmail.com>
	<20090907094432.GA23318@sirena.org.uk>
	<1252320709.5876.25.camel@odin> <20090909091857.GB4292@sortiz.org>
	<771cded00909100411m3c27711ej54d7b9823463b9d5@mail.gmail.com>
	<20090910173203.GD25960@rakim.wolfsonmicro.main>
	<20090911125937.GA6034@sortiz.org>
	<771cded00909170550o3fe757f5q51e8076fc0af7b45@mail.gmail.com>
	<f17812d70909221112laf6c182nf0c26253066310e9@mail.gmail.com>
	<f17812d70909221113iae6fa0ew8fa19a658cf90a1e@mail.gmail.com>
Message-ID: <20090922215559.GF4736@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 02:13:05AM +0800, Eric Miao wrote:
> Forwarded to correct mailing list manually, pity.

> >> Yes, MFD core driver can take this job also. But it addes more
> >> initialization code in custom MFD driver.

> > I'd agree with this.

> > I don't see any point that the use of the MFD API is mandatory here. This
> > is really a simple and straightforward task to add all the sub-devices
> > (as platform_device - though I don't like this platform_device at all), and
> > maybe in a specific manner the composite device needs, we don't really
> > need to involve all those mfd_cell, and resource copying stuffs.

The point I was making wasn't so much about using the MFD API itself as
about the fact that I'd expect the bit of the device driver that sits
under drivers/mfd to know about all the subdevices that needed
registering, especially for things which don't usually need any system
specific configuration.  I'd probably not have said anything if the
original code hadn't taken the entire list of subdevices in as platform
data.
