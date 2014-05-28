From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 12:33:51 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <5385B1B8.8070803@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
 <20140528093653.GN4730@lukather> <5385B1B8.8070803@redhat.com>
Message-ID: <20140528103351.GQ4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 11:51:52AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/28/2014 11:36 AM, Maxime Ripard wrote:
> > On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
> >> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >>> With level triggered interrupt mask / unmask will get called for each
> >>> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> >>> not a good idea. Instead move it to the set_type callback, which is typically
> >>> done only once for each irq.
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Yes move it out of mask/unmask but no, not into set_type().
> >>
> >> Can you not use the irqchip startup()/shutdown() callbacks
> >> instead?
> > 
> > I think we can use irq_request_resources then
> > https://lkml.org/lkml/2014/3/12/307
> 
> Sounds good, I'll modify the patch to move it here before posting a v2 of
> this series. Note v2 likely won't happen till this weekend, -ENOTIME.
> 
> > We could even merge the gpio_to_irq code into it.
> 
> Erm, no we need that as a separate function for the gpio_chip's to_irq
> callback.

Linus sent a patch stating otherwise a few weeks ago, and was
suggesting moving it to irq_startup.

https://lkml.org/lkml/2014/5/9/50

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/4f0e6e7a/attachment.sig>
