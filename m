From: michael@ellerman.id.au (Michael Ellerman)
Date: Tue, 02 Jul 2013 10:53:16 +1000
Subject: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1372726396.17904.1.camel@concordia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> Until now, the MSI architecture-specific functions could be overloaded
> using a fairly complex set of #define and compile-time
> conditionals. In order to prepare for the introduction of the msi_chip
> infrastructure, it is desirable to switch all those functions to use
> the 'weak' mechanism. This commit converts all the architectures that
> were overidding those MSI functions to use the new strategy.

The MSI code used to use weak functions, until we discovered they were
being miscompiled on some toolchains (11df1f0). I assume these days
we're confident they work correctly.

cheers
