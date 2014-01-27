From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:44:41 +0000
Subject: [PATCH 4/4] ASoC: tda998x: adjust the audio hw parameters from
 EDID
In-Reply-To: <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
Message-ID: <20140127204441.GZ11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 09:48:54AM +0100, Jean-Francois Moine wrote:

> +		eld_ver = eld[0] >> 3;
> +		if (eld_ver != 2 && eld_ver != 31)
> +			return 0;
> +
> +		mnl = eld[4] & 0x1f;
> +		if (mnl > 16)
> +			return 0;
> +
> +		sad_count = eld[5] >> 4;
> +		sad = eld + 20 + mnl;

Can this parsing code be factored out - it (or large parts of it) should
be usable by other HDMI devices shouldn't it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/2ec34ffc/attachment.sig>
