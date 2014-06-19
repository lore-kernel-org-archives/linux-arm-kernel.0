From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Jun 2014 08:45:45 -0500
Subject: [PATCH 4/9] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <CAFp+6iH+J4T=7pJU_+ZZKrgDwJWwQfznv9NWuy5SkLgz_j75_Q@mail.gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-5-git-send-email-antoine.tenart@free-electrons.com>
 <CAFp+6iEKLD_rLg84h3J2oyzw7vizEV-Eqo0e_jqurx_v9ZX2JA@mail.gmail.com>
 <20140606071106.GA30156@kwain>
 <CAFp+6iH+J4T=7pJU_+ZZKrgDwJWwQfznv9NWuy5SkLgz_j75_Q@mail.gmail.com>
Message-ID: <20140619134545.GB23782@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 04:32:03PM +0530, Vivek Gautam wrote:
> Hi,
> 
> On Fri, Jun 6, 2014 at 12:41 PM, Antoine T?nart
> <antoine.tenart@free-electrons.com> wrote:
> > Hi,
> >
> > On Fri, Jun 06, 2014 at 12:09:06PM +0530, Vivek Gautam wrote:
> >> On Thu, Jun 5, 2014 at 9:18 PM, Antoine T?nart
> >> <antoine.tenart@free-electrons.com> wrote:
> >> > Add the driver driving the Marvell Berlin USB PHY. This allows to
> >> > initialize the PHY and to use it from the USB driver later.
> >>
> >> Just out of curiosity, going forward we would like to have phy drivers based on
> >> generic phy framework (drivers/phy).
> >> Any particular reason that we are still adding phy drivers in usb-phy layer ?
> >>
> >> Looking at it, seems like it can very well be written based on phy framework.
> >
> > This USB controller are ChipIdea compatible, and the ChipIdea common
> > functions use the usb_phy framework. That's why this PHY driver is
> > there.
> 
> Ok, i see that now. In that case shouldn't we be moving even the chipidea
> drivers to use the generic phy functions to get the phy and init/exit it.

yes, we should :-)

> I think Felipe and Kishon can comment on this better, and tell how
> things should be. :-)

yeah, this will just make it a little more difficult to deprecate
current usb phy layer.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140619/c28e2865/attachment-0001.sig>
