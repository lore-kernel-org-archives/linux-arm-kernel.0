From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 3 Jan 2016 19:30:12 +0100
Subject: [PATCH v2] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
References: <1448055950-21190-1-git-send-email-leoli@freescale.com>
 <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
Message-ID: <20160103183012.GE1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 01:55:19PM +0100, Linus Walleij wrote:
> On Fri, Nov 20, 2015 at 10:45 PM, Li Yang <leoli@freescale.com> wrote:
> 
> > -       if (IS_ERR(i2c_imx->pinctrl)) {
> > +       /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
> > +       if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
> > +                       PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
> 
> This is one of the evils of deferred probe: you never know if
> something will eventually turn up. It feels wrong to bail out
> on deferred probe...
> 
> I have no better idea though.
> Acked-by

Linus, proper ack next time please, so patchwork will pick it up
automatically.

Li Yang: There have been some other changes to the imx driver. Could you
rebase against my for-next or for-4.5 and add Linus' ack? Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160103/53375360/attachment.sig>
