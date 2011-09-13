From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2011 18:35:13 +0200
Subject: [PATCH] ARM: CSR: call l2x0_of_init to init L2 cache of
	SiRFprimaII
In-Reply-To: <4E6F77C6.8040409@gmail.com>
References: <1315905006-21390-1-git-send-email-Baohua.Song@csr.com>
	<CAGsJ_4xtHsKpLqS81maGS5g=RHW+Paa09wKNVx3qEvxjCc8-Pw@mail.gmail.com>
	<4E6F77C6.8040409@gmail.com>
Message-ID: <201109131835.14230.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011, Rob Herring wrote:
> I have it in init_irq as I need the outer flush to work for SMP init.
> init_machine may be okay as well, but as early as possible is probably
> best. It depends if you are turning on the L2 or it is already on when
> you boot.
> 
> You could also just check your machine compatible string in this
> function, but calling it from a machine specific function is a cleaner
> solution.

I would suggest checking the specific "compatible" string of the l2x0
device node, and making sure that you have something specific to
prima2 in it.

That would easily let us combine this function with the respective
l2x0 init code for other dt based platforms later, by checking
multiple compatible values.

	Arnd
