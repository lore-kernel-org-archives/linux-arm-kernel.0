From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 10:51:43 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <518A8E6C.6070907@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com>
 <518A8E6C.6070907@st.com>
Message-ID: <20130509095143.GB7478@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 06:42:04PM +0100, Srinivas KANDAGATLA wrote:

Fix your mailer to word wrap within paragraphs.

> Ultimately the syscon_write use the regmap_update_bits, however we
> really want is the flexibility in using/referring the syscon
> registers/bits in both device-trees and non-device tree cases.

So what you're looking for here is some way to offload discovery of
register fields from the driver?

> The reason for these APIs, is the extent of syscon usage is very high
> in ST set-top-box parts.

> Without these new APIs, its very difficult to pass this information to
> the drivers.

I'm not 100% convinced that putting all this information into DT is a
good idea, and to the extent that it is sensible it feels like something
which might be useful with any device using register maps, not just
syscon.  For example many MFDs have similar needs - essentially the
system controllers are just a particular kind of MFD.  To me that says
that this should be outside syscon so other things can use it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/204dd9d8/attachment.sig>
