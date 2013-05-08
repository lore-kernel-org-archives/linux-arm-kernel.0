From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 21:48:10 +0200
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <518A8C1D.3090600@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de> <518A8C1D.3090600@st.com>
Message-ID: <201305082148.10933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> the pinctrl driver calls syconf_claim(np, "st,alt-control) to get a
> field and then do a read/write on the field.
> 
> Just in pinctrl driver we use around 50-100 sysconf registers scatters
> across different groups.
> 
> Without these new APIs, its very difficult to pass this information to
> the drivers.

But are those necessarily things you would configure using DT?

If there are so many registers that are shared between mutliple
subsystems, maybe using drivers/mfd/syscon for that is taking things
further than you should, since it is unlike what any of the other
SoC families need from syscon.

Can you describe how your syscon registers are laid out?
Which subsystems beside pinctrl need to directly interact
with it? Is there any logical structure in it or do you just
have tons of bits scattered around an MMIO area?

	Arnd
