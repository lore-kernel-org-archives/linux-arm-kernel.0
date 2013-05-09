From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 14:26:00 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <518B8F49.5020902@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com>
 <518A8E6C.6070907@st.com> <20130509095143.GB7478@sirena.org.uk>
 <518B8F49.5020902@st.com>
Message-ID: <20130509132600.GA3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 12:58:01PM +0100, Srinivas KANDAGATLA wrote:

> Currently, we have two bits of information which come from device trees.
> 1> The syscon bank/group definition itself.
> 2> syscon register offsets and bits information to the drivers.

> These are the 2 things which keep changing per each SOC.

> There is no other way to pass this information to the drivers other than
> passing them as part of their own device node and syscon node.

Sure there is, for example the drivers could have this information
internally as part of knowing which device they're working with or they
could take advantage of some patterns in the register map to store some
higher level information that they use to configure.

> >  and to the extent that it is sensible it feels like something
> > which might be useful with any device using register maps, not just
> > syscon.

> If you think this is going to be useful for other drivers, Am happy to
> move this out of syscon to regmap something like adding
> of_regmap_field_claim/regmap_field_claim/regmap_field_read/regmap_field_write/regmap_field_release
> functions.

> so any exiting drivers can still use the old syscon API to get the
> regmap instance.
> Alternatively they can use the new regmap APIs directly.

Well, I'd need to see the code to decide if it was sane but I do think
that if this is a good approach it's not syscon specific.  Anything like
this needs to be independent of DT too since not all architectures use
DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/4d182b81/attachment.sig>
