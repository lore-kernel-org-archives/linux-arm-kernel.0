From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 5 Oct 2010 14:31:54 +0200
Subject: [PATCH] ARM: PL330: Accept revisions of the dmac
In-Reply-To: <AANLkTinLkRG9oy6qxuez6iQOHSLazjj=X_v_G2Er9grW@mail.gmail.com>
References: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTimC5Ru-cTGVynnCu2NntHrHa9pB1HSGWEEJNZT7@mail.gmail.com>
	<AANLkTikeTyUtUQEobgi0eQX47jO0CQ2oGusojHv1ymED@mail.gmail.com>
	<AANLkTims+16hJT5m3e+_9vf5wfvtRyArHV2ttzbHxid9@mail.gmail.com>
	<AANLkTimzMD3RRH9qBp0AdQ86tOjaFjOAAokrNvo0ydad@mail.gmail.com>
	<AANLkTinLkRG9oy6qxuez6iQOHSLazjj=X_v_G2Er9grW@mail.gmail.com>
Message-ID: <AANLkTinaR3JsYfE4pkrzF3Xzp-ix2GB+Ti9NbssdH4On@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/7 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2010/9/7 Jassi Brar <jassisinghbrar@gmail.com>:
>
>>> +#define amba_config(d) AMBA_CONFIG_BITS((d)->periphid)
>>> +#define amba_rev(d) ? ?AMBA_REV_BITS((d)->periphid)
>>> +#define amba_manf(d) ? AMBA_MANF_BITS((d)->periphid)
>>> +#define amba_part(d) ? AMBA_PART_BITS((d)->periphid)
>>
>> Sorry I missed that I need to read periph_id[0,3] regs and form
>> Peripheral-ID from them,
>> These macros do the reverse - extract fields from the Peripheral-ID.
>> btw, you might want to close argument 'a' in parens as in ((a) & 0xfff) ?
>
> Oh OK I'll fix the macros and put the patch for Russells review in the
> patch tracker anyway, atleast getting the B105F00D magic defined
> somewhere can be helpful.

Russell has merged the apropriate field extraction macros to
<linux/amba/bus.h> so now you can use these, please respin
patch 6367/1 on top of that.

Yours,
Linus Walleij
