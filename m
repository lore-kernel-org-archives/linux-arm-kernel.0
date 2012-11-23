From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 23 Nov 2012 11:51:10 +0100
Subject: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
Message-ID: <20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 10:34:02AM +0000, Philip, Avinash wrote:
> On Fri, Nov 23, 2012 at 02:29:44, Thierry Reding wrote:
> > On Wed, Nov 21, 2012 at 06:41:02PM +0530, Philip, Avinash wrote:
> > [...]
> > > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > > +	if (IS_ERR(pinctrl))
> > > +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
> > 
> > I think we already discussed this, but shouldn't this be a fatal error?
> 
> I had checked relevant discussion and found this can be warning message.
> This is because most boards don't have pinctrl implemented at this point,
> or may never have.
> 
> https://lkml.org/lkml/2012/9/11/369
> 
> Any way I will change to
> dev_warn(&pdev->dev, "unable to select pin group\n");
> as in other drivers.

But in case pinctrl isn't implemented, shouldn't the implementation of
devm_pinctrl_get_select_default() just be a no-op?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/fcc46a7f/attachment-0001.sig>
