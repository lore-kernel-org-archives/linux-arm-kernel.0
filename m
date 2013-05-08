From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 08 May 2013 18:42:04 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <20130508150141.GA5057@opensource.wolfsonmicro.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com>
Message-ID: <518A8E6C.6070907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou for the comments.
On 08/05/13 16:01, Mark Brown wrote:
> On Wed, May 08, 2013 at 04:50:22PM +0200, Arnd Bergmann wrote:
>
>>> In many cases a single syconf register contains bits related to multiple
>>> devices, and therefore it need to be shared across multiple drivers at
>>> bit level. The same IP block can have different syscon mappings on
>>> different SOCs.
>> My feeling is that syscon is the wrong place for this functionality,
>> since regmap already handles (some of?) these issues. If you need
>> additional synchronization, it's probably best to extend regmap
>> as needed so other code besides syscon can take advantage of that
>> as well.
> This sounds like regmap_update_bits() ought to be all that's needed.

Ultimately the syscon_write use the regmap_update_bits, however we really want is the flexibility in using/referring the syscon registers/bits in both device-trees and non-device tree cases.

The reason for these APIs, is the extent of syscon usage is very high in ST set-top-box parts.

Without these new APIs, its very difficult to pass this information to
the drivers.

Thanks,
srini
