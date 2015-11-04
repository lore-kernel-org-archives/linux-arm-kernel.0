From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Nov 2015 08:24:56 -0800
Subject: [PATCH v4 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <3751073.AWmm18dvKK@wuerfel>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
 <3751073.AWmm18dvKK@wuerfel>
Message-ID: <20151104162456.GA6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Oct 30, 2015 at 09:28:55AM +0100, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 17:50:22 Jens Kuske wrote:
> > +               of_property_read_string_index(node, "clock-output-names",
> > +                                             i, &clk_name);
> > +
> > +               if (index == 17 || (index >= 29 && index <= 31))
> > +                       clk_parent = AHB2;
> > +               else if (index <= 63 || index >= 128)
> > +                       clk_parent = AHB1;
> > +               else if (index >= 64 && index <= 95)
> > +                       clk_parent = APB1;
> > +               else if (index >= 96 && index <= 127)
> > +                       clk_parent = APB2;
> > +
> > +               clk_reg = reg + 4 * (index / 32);
> > 
> 
> Same as for the reset driver, this probably means you should have one
> cell to indicate which bus it is for, and another cell for the
> index.

It's not really comparable to the reset driver.

What's happening here is that we have a single set of (contiguous)
registers, controlling gates from different parents.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/dd04a757/attachment.sig>
