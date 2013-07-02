From: michael@ellerman.id.au (Michael Ellerman)
Date: Tue, 2 Jul 2013 16:52:20 +1000
Subject: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <20130702073037.55a53642@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia>
 <20130702073037.55a53642@skate>
Message-ID: <20130702065220.GA20521@concordia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 07:30:37AM +0200, Thomas Petazzoni wrote:
> Dear Michael Ellerman,
> 
> On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
> > On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> > > Until now, the MSI architecture-specific functions could be overloaded
> > > using a fairly complex set of #define and compile-time
> > > conditionals. In order to prepare for the introduction of the msi_chip
> > > infrastructure, it is desirable to switch all those functions to use
> > > the 'weak' mechanism. This commit converts all the architectures that
> > > were overidding those MSI functions to use the new strategy.
> > 
> > The MSI code used to use weak functions, until we discovered they were
> > being miscompiled on some toolchains (11df1f0). I assume these days
> > we're confident they work correctly.
> 
> Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
> affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
> view on this?

Stop press.

I went back and found the old threads on this, it's been a while. It
looks like it was only gcc 4.1.[01] that miscompiled. The reference to
gcc 4.3.2 was WRT ellision of the unused code, which is a separate
issue.

The kernel blacklists gcc 4.1.[01] (see f9d1425), so weak should be
safe to use.

We merged the change to the PCI code anyway because we thought it was
nicer and it also avoided any problems with weak.

So pretend I never said anything :)

cheers
