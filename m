From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 19 Nov 2012 14:03:28 +0100
Subject: [PATCH 1/2] Fix build error in pwm-vt8500.c
In-Reply-To: <20121119092926.GE3290@n2100.arm.linux.org.uk>
References: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
 <1353290780-19413-2-git-send-email-linux@prisktech.co.nz>
 <20121119092926.GE3290@n2100.arm.linux.org.uk>
Message-ID: <20121119130327.GB31093@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 09:29:26AM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 03:06:19PM +1300, Tony Prisk wrote:
> > A missing '{' causes a build error in pwm-vt8500.c
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  drivers/pwm/pwm-vt8500.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> > index 970b0c6..806f72c 100644
> > --- a/drivers/pwm/pwm-vt8500.c
> > +++ b/drivers/pwm/pwm-vt8500.c
> > @@ -100,7 +100,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
> >  
> >  	err = clk_enable(vt8500->clk);
> > -	if (err < 0)
> > +	if (err < 0) {
> >  		dev_err(chip->dev, "failed to enable clock\n");
> >  		return err;
> >  	};
> 
> Why does this closing brace have a semicolon after it?

Tony,

can you remove the gratuitous semicolon while at it, please?

Thanks for spotting it Russell.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/65466348/attachment.sig>
