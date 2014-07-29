From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 18:36:31 +0100
Subject: [RFC 4/5] regulator: tps65090: Set voltage for fixed regulators
In-Reply-To: <1406651339-28901-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140729173631.GX17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:28:58PM +0200, Javier Martinez Canillas wrote:

> +#define tps65090_REG_VAR(_id, _sname, en_reg, _en_bits, _ops) \
> +	tps65090_REG_DESC(_id, _sname, en_reg, _en_bits, 0, 0, _ops)

I'd expect this to describe a variable regulator when in fact it
seems it describes a switch with no regulation.  Better name please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/dad4d276/attachment-0001.sig>
