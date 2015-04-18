From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Apr 2015 18:37:40 +0100
Subject: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
In-Reply-To: <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150418173740.GF26185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 04:14:08PM +0800, Koro Chen wrote:

> +/*
> + * The MTK AFE unit has a audio interconnect with MTK_AFE_INTERCONN_NUM_INPUT
> + * inputs and MTK_AFE_INTERCONN_NUM_OUTPUT outputs. Below table holds the
> + * register/bits to set to connect an input with an output.
> + */
> +static const struct mtk_afe_connection
> +	connections[MTK_AFE_INTERCONN_NUM_INPUT][MTK_AFE_INTERCONN_NUM_OUTPUT] = {
> +	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
> +	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},

What are the constraints on using this - is it one input to one output
only or can we do mixing or duplication?  The register interface
definitely does look like something asking for runtime configuration.

It'd also be nice to have less magic numbers in the table, at least for
the indexes (which I guess correspond to some of the defines in the
headers)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/28fcacb5/attachment.sig>
