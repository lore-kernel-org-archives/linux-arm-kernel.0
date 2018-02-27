From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Feb 2018 08:12:11 +0100
Subject: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
In-Reply-To: <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
References: <20180217142235.28541-1-embed3d@gmail.com>
 <20180219081050.vvfhnbw4foved2fb@flea.lan>
 <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
Message-ID: <20180227071211.4c5okbwcp5qjx4ok@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 10:29:29PM +0100, Philipp Rossak wrote:
> 
> 
> On 19.02.2018 09:10, Maxime Ripard wrote:
> > On Sat, Feb 17, 2018 at 03:22:35PM +0100, Philipp Rossak wrote:
> > > Right now the performance govenor is the default frequency govenor on
> > > sunxi devices. This causes some general problems.
> > > When the cpu is idle the cpu runs with its maximum frequency.
> > > This causes a higher cpu temperature in the idle state. When the cpu is
> > > now under load the cpu gets with that higher idle temperature now faster
> > > to its thermal limits.
> > > An other big problem of the performace govenor is the missing
> > > thermal throttling. Some tests with cpuburn resulted in a system crash
> > > when the soc reached its thermal limits since no thermal throttling
> > > occurred.
> > 
> > This won't change anything with cpuburn. While cpuburn will be
> > running, ondemand will increase the frequency of the cores to the
> > maximum frequency, putting yourself in the exact same situation.
>
> I see here a totally different behavior on the hardware (Bananapi M2, A31s).
> First ondemand increases the cpu frequency, when the maximum temperature is
> reached, then it throttles down the cpu step by step to its minimum.

This is the thermal throttling, not the cpufreq governor.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/1b88cb25/attachment.sig>
