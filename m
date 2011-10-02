From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 22:53:24 +0200
Subject: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <20111002204106.GB5811@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
Message-ID: <2726393.3Oc3SrGyN4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 21:41:07 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> > This driver only builds correctly on platforms that use
> > GPIOLIB. Disable it otherwise.
> 
> No, gpiolib is one implementation of the GPIO API but if platforms want
> to go and define their own that's currently OK (personally I think at
> this point we should just be converting all the stragglers over to
> gpiolib).  As things stand we shouldn't have dependencies on a
> particular implementation of the API.

Thanks for the explanation!

Is there any other symbol that I can test then?

I noticed that a lot of places use 'depends on GPIOLIB' or
'#ifdef CONFIG_GPIOLIB', are those usually wrong, too?

	Arnd
