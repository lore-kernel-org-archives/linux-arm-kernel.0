From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Aug 2013 07:04:41 +0200
Subject: [PATCH 4/5] pinctrl: imx: do not fail when parsing a function
 fails
In-Reply-To: <CACRpkdaFNNtEbCx2AKXuFW0MPFtkwkY9WOxUkmxJaAx0aDP11w@mail.gmail.com>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-5-git-send-email-s.hauer@pengutronix.de>
 <CACRpkdaFNNtEbCx2AKXuFW0MPFtkwkY9WOxUkmxJaAx0aDP11w@mail.gmail.com>
Message-ID: <20130815050441.GE26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:37:32PM +0200, Linus Walleij wrote:
> On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > When parsing a function fails this is no reason to make the whole
> > driver fail. Just continue with the next function.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> (...)
> > -       for_each_child_of_node(np, child) {
> > -               ret = imx_pinctrl_parse_functions(child, info, i++);
> > -               if (ret) {
> > -                       dev_err(&pdev->dev, "failed to parse function\n");
> > -                       return ret;
> > -               }
> > -       }
> > +       for_each_child_of_node(np, child)
> > +               imx_pinctrl_parse_functions(child, info, i++);
> 
> But is there a reason to stop printing an error message
> about it?

imx_pinctrl_parse_functions won't fail without printing an error message
itself, so this message is rather redundant.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
