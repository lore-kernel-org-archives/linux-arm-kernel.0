From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 19:49:05 +0000
Subject: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
In-Reply-To: <50326A3E.9070607@antcom.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
 <083DF309106F364B939360100EC290F823A0354A3D@eu1rdcrdc1wx030.exi.nxp.com>
 <50326A3E.9070607@antcom.de>
Message-ID: <201208201949.06530.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Roland Stigge wrote:
> On 08/20/2012 06:26 PM, Kevin Wells wrote:
> > I've never had my hands on a PNX4008 chip at NXP, but I do believe they
> > are the same IP. That specific I2C IP was used in a number of NXP/Phillips
> > chips besides the PNX4008/LPC32xx. I don't think there are any PNX4008's in
> > the wild, and even working in NXP, I can't find any non-marketing reference
> > material for that part (including the user manual).
> 
> Considering this, it might be a good idea to remove support for PNX4008
> (arch/arm/mach-pnx4008/) altogether. It's hard to maintain support for
> hardware which isn't available, even at NXP. It would also simplify
> maintenance of mach-lpc32xx because the overlap currently makes me
> always wonder if the respective changes still work with mach-pnx4008.
> 
> Any opposition?
> 
> 
> PS: I just wonder how mach-pnx4008 came into the kernel at all...

According to the git logs, Vitaly Wool originally added support for the
platform in 2006 when working at MontaVista, and that year was also the
last time he or anyone else from that company contributed anything in
that directory. Russell was the only other person to make substantial
contributions to it, but they all seem to be cross-platform changes.

In the platform code, there is only a single board number reserved,
with the name of the SoC: MACHINE_START(PNX4008, "Philips PNX4008").
This indicates that whoever was actually using the code did not have
their board code upstream and relied on out-of-tree patches for the
platform.

>From all I can tell, the PNX4008 family probably went to ST-Ericsson,
not to NXP in the various acquisitions and mergers that happened
around NXP. This explains why Kevin has no documentation or hardware
for it. On the ST-Ericsson web site, I could find some information
about the PNX4908, presumably a follow-on chip, but not about PNX4008,
so I guess the company also considers the product line dead.

Finally, the chips seems to be targetted at mobile phones and was
introduced seven years ago, which is multiple generations of
products in that market, so probably people stopped caring about
them long ago, unlike embedded chips from the same era for other
markets.

I'd say let's wait for Vitaly to reply on this matter, if he doesn't
care about the code, we can kill it off in 3.7 or 3.8.

	Arnd
