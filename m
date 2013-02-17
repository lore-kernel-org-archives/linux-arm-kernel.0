From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Feb 2013 14:01:27 +0000
Subject: [PATCH 02/11] ARM: samsung: fix assembly syntax for new gas
In-Reply-To: <20130216232550.GQ17833@n2100.arm.linux.org.uk>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-3-git-send-email-arnd@arndb.de>
 <20130216232550.GQ17833@n2100.arm.linux.org.uk>
Message-ID: <201302171401.27667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 02:49:18PM +0100, Arnd Bergmann wrote:
> > Recent assembler versions complain about extraneous
> > whitespace inside [] brackets. This fixes all of
> > these instances for the samsung platforms. We should
> > backport this to all kernels that might need to
> > be built with new binutils.
> 
> I hope that's also been reported as a bug to the binutils people.

No, I did not think of that. There were a lot of bug reports for
similar issues and I assumed that there was a good reason for
the change, but I agree that it sounds like a regression, especially
since the code that triggers the error should not be ambiguous and
there was never a warning about it.

	Arnd
