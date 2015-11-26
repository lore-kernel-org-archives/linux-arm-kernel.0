From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 26 Nov 2015 08:14:43 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/2] phy-sun4i-usb: Use
 of_match_node to get model specific config data
In-Reply-To: <CAGb2v64XL=bptxoCwiVkf8u-EfckpuASS3Foo=Q3i4a_6CaJYA@mail.gmail.com>
References: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v64XL=bptxoCwiVkf8u-EfckpuASS3Foo=Q3i4a_6CaJYA@mail.gmail.com>
Message-ID: <20151126071443.GA28184@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 12:22:59PM +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 26, 2015 at 12:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > +
> >  static const unsigned int sun4i_usb_phy0_cable[] = {
> >         EXTCON_USB,
> >         EXTCON_USB_HOST,
> > @@ -511,10 +578,16 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct device_node *np = dev->of_node;
> >         struct phy_provider *phy_provider;
> > -       bool dedicated_clocks;
> > +       const struct of_device_id *match;
> >         struct resource *res;
> >         int i, ret;
> >
> > +       match = of_match_node(sun4i_usb_phy_of_match, dev->of_node);
> 
> You can use of_device_get_match_data() for slightly less code. This
> will also let you keep the of_device_id table where it was, at the
> bottom.
> 
> > +       if (!match) {
> 
> I'm working on something similar in the axp20x driver. Is there any
> case of_match_node or of_device_get_match_data can fail?
> 
> 

Hello

I am working on some patch for that case and the conclusion was that case is possible.
See https://lkml.org/lkml/2015/11/12/97
So it is better to check it.

Regards
