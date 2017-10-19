From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 19 Oct 2017 19:35:40 +0900
Subject: [PATCH net-next v2 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <CAK7LNARuoK-M9iKyP7JxRgH7naA+teikqZMOHm3f2wykEieqLw@mail.gmail.com>
References: <20171018192359.243C.4A936039@socionext.com>
 <CAK7LNARuoK-M9iKyP7JxRgH7naA+teikqZMOHm3f2wykEieqLw@mail.gmail.com>
Message-ID: <20171019193540.0F35.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Oct 2017 09:29:03 +0900 <yamada.masahiro@socionext.com> wrote:

> 2017-10-18 19:23 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> > On Mon, 16 Oct 2017 00:08:21 +0900 <yamada.masahiro@socionext.com> wrote:
> 
> >> priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
> >> if (IS_ERR(priv->rst))
> >>           return PTR_ERR(priv->rst);
> >
> > The clk and reset are optional in the driver.
> > Referring to your suggested method, I'll fix the part of clk and reset.
> >
> 
> 
> Why is clk optional?

Indeed. My check point was wrong.
This clk property should be treated as "required".

In v2, the clock enabling code moved to ndo_init().
Although probing the driver succeeds without clk,
enabling the driver fails clearly.

---
Best Regards,
Kunihiko Hayashi
