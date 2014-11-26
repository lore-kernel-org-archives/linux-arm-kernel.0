From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 26 Nov 2014 19:57:08 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141126181934.GL2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <20141126172857.GA26157@amd>
 <20141126181934.GL2817@atomide.com>
Message-ID: <201411261957.08860@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [141126 09:31]:
> > On Tue 2014-10-28 01:01:38, Aaro Koskinen wrote:
> > > Hi,
> > > 
> > > On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren 
wrote:
> > > > +
> > > > +	if (!of_have_populated_dt())
> > > > +		pr_warn("WARNING: legacy booting deprecated, please
> > > > update to boot with .dts\n"); +
> > > 
> > > Maybe use WARN so that the warning is more verbose and
> > > kernel gets tainted?
> > 
> > Well.. Pali still has regression where /proc/cpuinfo changes
> > in a way that breaks existing userspace, when dt is used on
> > N900.
> > 
> > And rmk was less then helpfull...
> 
> Maybe Pali can try to restart that discussion? To me it seems
> the /proc/cpuinfo should be the same as it's a user
> interface. Sorry forgot the details of the previous
> discussion..
> 

Yes, two days ago I again wrote emails about this problem...

E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774

> And with which app was that? Sorry I forgot..
> 

More applications/libraries for N900 which running on Maemo 5 
system. Some of them are Nokia proprietary, some of them are open 
source and some are mine.

Basically problem is that non DT boot provides this info in 
/proc/cpuinfo:

Hardware        : Nokia RX-51 board
Revision        : 0012

New DT boot provides this:

Hardware        : Generic OMAP3 (Flattened Device Tree)
Revision        : 0000

> It's weird that it's not been an issue for other though?
> 
> > Should we maybe solve that before adding backtraces to our
> > boot messages?
> 
> With this warning we want to notify the people actually using
> mainline kernel on omap3 that they should update their
> systems. And also let us know on this list about the
> regressions, so I think that's quite valuable.
> 
> Regards,
> 
> Tony

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/fc7e105c/attachment.sig>
