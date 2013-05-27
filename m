From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 May 2013 12:32:03 +0200
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
Message-ID: <201305271232.03644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 May 2013, Daniel Tang wrote:
> > On Saturday 25 May 2013, Daniel Tang wrote:

> > The one remaining bit that sticks out is the clcd platform data. As I
> > said before, I won't require you to convert that to DT in order to
> > get your code merged, but I'd also really like to see that happen,
> > as we will also need that to get rid of auxdata on the ARM reference
> > platforms (integrator, versatile, realview, vexpress).
> 
> How would you like me to convert the platform data to DT? AFAIK, the
> clcd driver isn't aware of DT so the only way is to use the AUXDATA right now.

There are two basica approaches we could take:

a) add DT support to the clcd driver, using the of_get_videomode()
helper and any other properties that need to be added.

b) add a new KMS driver for this hardware that can be used as an
alternative to the existing one and that works with DT.

	Arnd
