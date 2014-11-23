From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 23 Nov 2014 16:47:27 +0100
Subject: [PATCH 5/9] rc: sunxi-cir: Add support for the larger fifo found
 on sun5i and sun6i
In-Reply-To: <546F103D.6050004@redhat.com>
References: <1416498928-1300-1-git-send-email-hdegoede@redhat.com>
 <1416498928-1300-6-git-send-email-hdegoede@redhat.com>
 <20141120142856.16b6562d@recife.lan>
 <20141121082620.GJ24143@lukather> <546EFAE1.9050506@redhat.com>
 <20141121095934.GA4752@lukather> <546F103D.6050004@redhat.com>
Message-ID: <20141123154727.GK4752@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 11:13:17AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/21/2014 10:59 AM, Maxime Ripard wrote:
> > On Fri, Nov 21, 2014 at 09:42:09AM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11/21/2014 09:26 AM, Maxime Ripard wrote:
> >>> Hi Mauro,
> >>>
> >>> On Thu, Nov 20, 2014 at 02:28:56PM -0200, Mauro Carvalho Chehab wrote:
> >>>> Em Thu, 20 Nov 2014 16:55:24 +0100
> >>>> Hans de Goede <hdegoede@redhat.com> escreveu:
> >>>>
> >>>>> Add support for the larger fifo found on sun5i and sun6i, having a separate
> >>>>> compatible for the ir found on sun5i & sun6i also is useful if we ever want
> >>>>> to add ir transmit support, because the sun5i & sun6i version do not have
> >>>>> transmit support.
> >>>>>
> >>>>> Note this commits also adds checking for the end-of-packet interrupt flag
> >>>>> (which was already enabled), as the fifo-data-available interrupt flag only
> >>>>> gets set when the trigger-level is exceeded. So far we've been getting away
> >>>>> with not doing this because of the low trigger-level, but this is something
> >>>>> which we should have done since day one.
> >>>>>
> >>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>
> >>>> As this is meant to be merged via some other tree:
> >>>>
> >>>> Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> >>>
> >>> I think merging it through your tree would be just fine.
> >>>
> >>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> Heh, I was thinking it would be best if it went through Maxime's tree because
> >> it also has some deps on new clk stuff (well the dts have deps on that), but either
> >> way works for me.
> >>
> >> Maxime if you want this go through Mauro's tree, I can send a pull-req to Mauro
> >> (I'm a linux-media sub-maintainer), so if that is the case let me know and I'll
> >> prepare a pull-req (after fixing the missing reset documentation in the bindings).
> > 
> > So much for not reading the cover letter... Sorry.
> > 
> > We're getting quite close to the end of the ARM merge window, and I
> > got a couple comments, Lee hasn't commented yet, so I'd say it's a bit
> > too late for this to come in.
> 
> Oh, but this was not intended for 3.19, this can wait till 3.20 from my pov,
> sorry if that was not clear. I was assuming that the merge window was more
> or less closed already, so that this going into 3.20 was expected.

Perfect then :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141123/10f124e0/attachment.sig>
