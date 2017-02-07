From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Feb 2017 16:05:08 +0100
Subject: [PATCH RESEND] ARM: ep93xx: Disable TS-72xx watchdog before
 uncompressing
In-Reply-To: <SN1PR0101MB1565DDD368EF9D0F9F9ACD9DD04C0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170202201226.29631-1-f.fainelli@gmail.com>
 <SN1PR0101MB1565DDD368EF9D0F9F9ACD9DD04C0@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <2082981.zMc11d8l12@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 2, 2017 8:43:52 PM CET Hartley Sweeten wrote:
> On Thursday, February 02, 2017 1:12 PM, Florian Fainelli wrote:
> > The TS-72xx/73xx boards have a CPLD watchdog which is configured to
> > reset the board after 8 seconds, if the kernel is large enough that this
> > takes about this time to decompress the kernel, we will encounter a
> > spurious reboot.
> >
> > Do not pull ts72xx.h, but instead locally define what we need to disable
> > the watchdog.
> >
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Arnd, this is a recent, so you can queue this up, thanks!
> 
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> or Tested-by/Acked-by as appropriate...
> 

Too bad, this really gets in the way of a future multiplatform
ep93xx configuration as that doesn't easily allow us to have
board specific hacks in the decompressor.

Applied to next/soc with Hartley's reviewed-by tag.

It's not clear from your description if this is needed for stable
backports. If it is, please write to stable at vger.kernel.org
once it is merged upstream.

	Arnd
