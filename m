From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Feb 2016 21:28:56 +0000
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <4609707.AR30v8FONr@wuerfel>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <2686474.cvCA6vY47l@wuerfel> <20160212200311.GB11402@sirena.org.uk>
 <4609707.AR30v8FONr@wuerfel>
Message-ID: <20160212212856.GA18988@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 09:35:26PM +0100, Arnd Bergmann wrote:

> syscon is probably fine because it only sets that flag based on the
> "little-endian" DT property and I don't see anything setting that
> (except the one platform that did so incorrectly).

Though it should be able to remove that as the regmap code will also
parse the property.  Probably worth double checking that works as
intended though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/d83d1fdb/attachment.sig>
