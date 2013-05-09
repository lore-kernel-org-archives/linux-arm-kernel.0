From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 May 2013 21:25:01 +0200
Subject: [RFC PATCH 1/2] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <Pine.LNX.4.44L0.1305091108130.1796-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305091108130.1796-100000@iolanthe.rowland.org>
Message-ID: <201305092125.01607.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 May 2013, Alan Stern wrote:
> > > The #else part of this isn't needed, and I doubt very much that it
> > > would work correctly if it was needed.
> >
> > As Arnd suggestion,so I written else part.
> 
> The existing code doesn't have a #else part, and I don't think you need 
> to add one.

I had commented in an earlier (Linaro internal) review that function
declarations should not be hidden inside of an #ifdef unless there
is an #else clause defining an alternative.

I did not want to suggest with that adding an #else for the fun of it,
of course it should only be there if actually needed.

	Arnd
