From: simon@sequanux.org (Simon Guinot)
Date: Thu, 5 May 2011 07:50:22 +0000
Subject: [PATCH v2] kirkwood: add dir-665 support
In-Reply-To: <BANLkTi=Tmqhq2q9Qs_5kNEZ5229ePJ2Cuw@mail.gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<1304496346-13557-1-git-send-email-camhirundo@gmail.com>
	<20110504081627.GY19806@kw.sim.vm.gnt>
	<BANLkTi=Tmqhq2q9Qs_5kNEZ5229ePJ2Cuw@mail.gmail.com>
Message-ID: <20110505075022.GB19806@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hirundo,

On Thu, May 05, 2011 at 08:11:01AM +0800, Hirundo Cam wrote:
> Hi Simon
> 
> 2011/5/4 Simon Guinot <simon@sequanux.org>:
> > Hi Hirundo,
> >
> > On Wed, May 04, 2011 at 04:05:46PM +0800, Hirundo Cam wrote:
> >> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
> >> LEDs, GPIO, Buttons remains unknown.
> >>
> >> To use this patch, on board u-boot must also be recompiled and replaced.
> >
> > Just for curiosity, what is the problem the stock U-Boot ?
> >
> > Regards,
> >
> 
> Just as Jean-Christophe said,
> I guess the mach-type id in origin u-boot which shipped with the
> DIR-665 is differed.
> Hence the u-boot must update to the new mach-type ID.

Not necessarily. If the stock U-Boot allow to save the environment
variables, you can use the following commands:

setenv arcNumber 3487; setenv mainlineLinux yes; saveenv; reset

> 
> It is hard to find out which the origin mach-type has been used. I'm
> not sure if hexdump
> could help.

Probably 527. To be sure, you could boot a kernel compiled with the
option CONFIG_DEBUG_LL enabled. If the kernel fail to find a valid
machine entry, the given number will be displayed.

> 
> Anyway, I just replaced the u-boot and get it boot luckly.

Yes, but it is a risky operation for a user.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110505/ed0a6893/attachment.sig>
