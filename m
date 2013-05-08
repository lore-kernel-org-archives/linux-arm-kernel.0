From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 May 2013 16:01:41 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <201305081650.23264.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
Message-ID: <20130508150141.GA5057@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 04:50:22PM +0200, Arnd Bergmann wrote:

> > In many cases a single syconf register contains bits related to multiple
> > devices, and therefore it need to be shared across multiple drivers at
> > bit level. The same IP block can have different syscon mappings on
> > different SOCs.

> My feeling is that syscon is the wrong place for this functionality,
> since regmap already handles (some of?) these issues. If you need
> additional synchronization, it's probably best to extend regmap
> as needed so other code besides syscon can take advantage of that
> as well.

This sounds like regmap_update_bits() ought to be all that's needed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130508/7fc89de4/attachment.sig>
