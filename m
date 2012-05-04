From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 16:24:17 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120503144609.GK4141@pengutronix.de>
References: <201205031350.35476.arnd@arndb.de>
 <20120503144609.GK4141@pengutronix.de>
Message-ID: <201205041624.17850.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Sascha Hauer wrote:
> I don't think that enforcing DT only in multiplatform kernels will speed
> up porting to DT. As a platform maintainer I am interested in building
> multiplatform Kernels, but our customers are mostly uninterested in
> this. They probably disable other platforms anyway to save the binary space.

I was not asking about enabling multiple board files but multiple mach-*
directories, which is something that I'm probably more interested in than
you are, and the customers you refer to would certainly not do that if
they only want to run on one board.

This is really about people who distribute kernels that run on a wide
variety of machines across soc vendor boundaries, people like
ubuntu or cyanogenmod. The question is really whether you see a reason
why they should enable the 25 non-DT board files on your platform, rather
than helping out getting DT support for the machines they are
interested in?

	Arnd
