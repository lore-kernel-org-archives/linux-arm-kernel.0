From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2011 17:04:18 +0200
Subject: [RFC] using amba_pl08x driver for s3c64xx SoCs
In-Reply-To: <CAGOxZ51TcNcC9gAVbuv6DTpj7SXCNbf+r+DjjByi20SYPj-zmw@mail.gmail.com>
References: <CAGOxZ50Rz3ynmkuoJb9Pgc0b1pG++-CB9kUtU92zKYtfP3jtRg@mail.gmail.com>
	<CACRpkdasYKx8C7fR1heiQDnJgJMvLa1VuQNhQ+gu5F6ea7d3oA@mail.gmail.com>
	<CAGOxZ53edhKA=VbhJJKG--LoG6P8Y+ubKdH5-4woDgBEbTdtVQ@mail.gmail.com>
	<CACRpkdaYxbgqYZZSgRJmfBDWPyp-SQrviK50UvHrkTCO=B=6NQ@mail.gmail.com>
	<4E3F6550.6010204@st.com>
	<CAGOxZ51TcNcC9gAVbuv6DTpj7SXCNbf+r+DjjByi20SYPj-zmw@mail.gmail.com>
Message-ID: <CACRpkdbxRkxeXChycehzhnBKOBcoO2yOaSBb5Tgc=i+b-kSEXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 6:51 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:

> static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
> {
> ? ? ? ?struct pl08x_dma_chan *plchan = ch->serving;
> ? ? ? ?struct pl08x_driver_data *pl08x;
> ? ? ? ?unsigned int val;
>
> ? ? ? ?if(plchan == NULL)
> ? ? ? ? ? ? ? ?return false;
>
> ? ? ? ?pl08x = plchan->host;
>
> ? ? ? ?if(pl08x->vd->is_pl080_s3c)
> ? ? ? ? ? ? ? ?val = readl(ch->base + PL080S_CH_CONFIG);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?val = readl(ch->base + PL080_CH_CONFIG);
>
> ? ? ? ?return val & PL080_CONFIG_ACTIVE;
> }

Aha, that's the bug :-)

Acked-by.

Thanks,
Linus Walleij
