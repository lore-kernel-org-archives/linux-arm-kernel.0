From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 Aug 2014 09:12:32 +0200
Subject: [PATCH] This adds a generic PWM framework driver for the PWM
 controller
In-Reply-To: <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
References: <20140818180316.31807.3445.stgit@studio>
 <20140818192318.GJ15297@lukather>
 <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
 <20140818201929.GL15297@lukather>
 <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Message-ID: <20140823071232.GY15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:11:40AM -0400, jonsmirl at gmail.com wrote:
> On Mon, Aug 18, 2014 at 4:19 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl at gmail.com wrote:
> >> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
> >> >> found on Allwinner SoCs.x
> >> >>
> >> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> >> >
> >> > Is there any notable difference with Alexandre's driver?
> >> > https://lkml.org/lkml/2014/5/19/568
> >> >
> >> > If so, why didn't you posted incremental patches on top of his driver?
> >>
> >> Better A10 support.
> >
> > Better how?
> >
> >> And I wrote this one without know about his.
> >
> > So you're just require us to trash an already extensively reviewed
> > driver and start from scratch again?
> 
> Forget mine then.
> 
> Problems in the other one....
> 1) The math is not right in either patch. Selsinork has been checking
> mine with a scope and just found another math error in mine. The
> internal math needs to be done in picoseconds or round off errors mess
> up the high frequency outputs (24Mhz, 12Mhz, 8Mhz, ...).

Feel free to report this to Alexandre so he fixes it then.

> 3) By-pass mode on the A20 is not implemented.
> 2) A10 is not correctly handled. Specifically the prescaler is
> different on the A10 vs A20.

And these can be sent as patches on top of Alexandre's driver, and
they would be very much welcome.

Remember to run scripts/checkpatch.pl before sending them though, and
by a quick look at your driver, you should also read
Documentation/CodingStyle.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140823/b7c48a9f/attachment.sig>
