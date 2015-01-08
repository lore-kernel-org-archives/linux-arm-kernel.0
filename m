From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jan 2015 10:39:21 +0100
Subject: [PATCH v2 03/11] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <CAGb2v64c9ZgyUhzneyK3Gqh8XS=qT682_eKZe3_BYm48JMqCNg@mail.gmail.com>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
 <1418886058-8145-4-git-send-email-wens@csie.org>
 <20141219180759.GP4820@lukather>
 <CAGb2v64c9ZgyUhzneyK3Gqh8XS=qT682_eKZe3_BYm48JMqCNg@mail.gmail.com>
Message-ID: <20150108093921.GQ7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 10:15:19AM +0800, Chen-Yu Tsai wrote:
> >> +     clk_data->clks = devm_kcalloc(&pdev->dev, count, sizeof(struct clk *),
> >
> > Hmmm, are you sure of that sizeof?
> 
> Quite sure. Code in clk-sunxi.c for gates:
> 
>     clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
> 
> Note I'm using kcalloc here.
> 
> Also definition for clk_data:
> 
>     struct clk_onecell_data {
>             struct clk **clks;
>             unsigned int clk_num;
>     };

Ah, right, my bad :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/2153110c/attachment.sig>
