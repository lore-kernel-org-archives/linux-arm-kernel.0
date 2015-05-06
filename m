From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 May 2015 18:28:46 +0100
Subject: [PATCH v4 04/10] eeprom: Add a simple EEPROM framework for
 eeprom consumers
In-Reply-To: <1427752670-17219-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427752670-17219-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150506172846.GC22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:57:50PM +0100, Srinivas Kandagatla wrote:

> +
> +	for (i = 0; i < cell->nblocks; i++) {
> +		rc = regmap_raw_read(eeprom->regmap, cell->blocks[i].offset,
> +				      buf + offset, cell->blocks[i].count);

I *think* this is probably OK but please double check that the count
here is in bytes rather than words, it's a bit confusing since I'd read
a count as being in words.  Otherwise I think the regmap usage here all
looks good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/99a5b6e6/attachment.sig>
