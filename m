From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 2 Jul 2013 07:30:37 +0200
Subject: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <1372726396.17904.1.camel@concordia>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia>
Message-ID: <20130702073037.55a53642@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael Ellerman,

On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
> On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> > Until now, the MSI architecture-specific functions could be overloaded
> > using a fairly complex set of #define and compile-time
> > conditionals. In order to prepare for the introduction of the msi_chip
> > infrastructure, it is desirable to switch all those functions to use
> > the 'weak' mechanism. This commit converts all the architectures that
> > were overidding those MSI functions to use the new strategy.
> 
> The MSI code used to use weak functions, until we discovered they were
> being miscompiled on some toolchains (11df1f0). I assume these days
> we're confident they work correctly.

Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
view on this?

Another option would be to have architecture register some msi_arch_ops
structure, with a set of operations, which I believe is a pattern that
is more widespread in the kernel than weak functions.

Thoughts?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
