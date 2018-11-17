From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Sat, 17 Nov 2018 22:54:08 +0800
Subject: [PATCH V3 2/7] net: lorawan: Add LoRaWAN socket module
In-Reply-To: <20181116.203200.1638720313402188457.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-3-starnight@g.ncu.edu.tw>
 <20181116.203200.1638720313402188457.davem@davemloft.net>
Message-ID: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Miller <davem@davemloft.net> ? 2018?11?17? ?? ??12:32???
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Thu, 15 Nov 2018 00:01:23 +0800
>
> > +#define      lrw_get_mac_cb(skb)     ((struct lrw_mac_cb *)skb->cb)
>
> Please make this a static inline function.  If the identifier is all lowercase
> programmers expect it to be real code not a CPP macro.

Okay!  Sure

> > +#define      LORAWAN_MODULE_NAME     "lorawan"
> > +
> > +#define      LRW_DBG_STR(fmt)        LORAWAN_MODULE_NAME": "fmt
> > +#define      lrw_info(fmt, ...)      (pr_info(LRW_DBG_STR(fmt), ##__VA_ARGS__))
> > +#define      lrw_dbg(fmt, ...)       (pr_debug(LRW_DBG_STR(fmt), ##__VA_ARGS__))
>
> Just define "pr_fmt()" appropriately and you don't need to play these kinds
> of games.
>
> Set pr_fmt() and call pr_info() and pr_debug() directly.

After checking printk.h again, I get the idea of the comment.
"pr_fmt()" is more convenient!

Thanks for the reviewing.  I will make new patches.

Jian-Hong Pan
