From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 28 May 2013 11:52:52 +0100
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <201305271231.40693.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
 <201305271231.40693.arnd@arndb.de>
Message-ID: <1369738372.3148.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 11:31 +0100, Arnd Bergmann wrote:
> On Monday 27 May 2013, Daniel Tang wrote:
> > > The one remaining bit that sticks out is the clcd platform data. As I
> > > said before, I won't require you to convert that to DT in order to
> > > get your code merged, but I'd also really like to see that happen,
> > > as we will also need that to get rid of auxdata on the ARM reference
> > > platforms (integrator, versatile, realview, vexpress).
> > 
> > How would you like me to convert the platform data to DT? AFAIK, the clcd
> > driver isn't aware of DT so the only way is to use the AUXDATA right now.
> 
> Linus Walleij mentioned on IRC that Pawel Moll already posted a series
> that adds DT support for clcd:
> 
> http://lists.freedesktop.org/archives/dri-devel/2013-April/037519.html
> 
> The series does a few more things, but you can probbly split out the
> parts you need and base on that.

The main "issue" with the series is its dependency on Laurent Pinchart's
Common Display Framework (or rather on the progress of its upstreaming).
I'm planning to discuss this in details in during the Linaro Connect in
Dublin, but generally, if it's not getting merged in the next window,
I'll spin the series to use the standard video modes bindings instead of
CDF. This will make me hurt on Versatile Express, but should work for
others.

Pawe?
