From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Dec 2013 21:05:29 +0100
Subject: [PATCH 01/10] net: stmmac: Enable stmmac main clock when probing
 hardware
In-Reply-To: <CAGb2v65YOSq_BMWSzSHX8w_hbo+0vwquBT2pnLuwNVZkWRfLvA@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-2-git-send-email-wens@csie.org>
 <20131207103335.GL24519@lukather>
 <CAGb2v65YOSq_BMWSzSHX8w_hbo+0vwquBT2pnLuwNVZkWRfLvA@mail.gmail.com>
Message-ID: <20131210200529.GD3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 09, 2013 at 10:43:29AM +0800, Chen-Yu Tsai wrote:
> >> @@ -2759,15 +2760,18 @@ struct stmmac_priv *stmmac_dvr_probe(struct device *device,
> >>               }
> >>       }
> >>
> >> +     clk_disable_unprepare(priv->stmmac_clk);
> >> +
> >
> > Hu? Why do you disable the clock? don't you need it afterwards?
> 
> The clock is enabled in *_open (when the network interface is used),
> and disabled in *_close.

Maybe it is the real issue then.

Why don't you move the clk_disable to _remove then?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/6c85ba55/attachment.sig>
