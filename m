From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 17:22:47 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100715160922.GA4119@debian>
References: <20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
	<20100715160922.GA4119@debian>
Message-ID: <20100715162247.GH29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 09:39:22PM +0530, Rabin Vincent wrote:
> In your earlier patch, you proceeded with the probe if the error from
> clk_get() was -ENOENT, but not in this version.  Isn't the -ENOENT
> special handling preferable, since it avoids the need to change all
> existing platforms?

Well, the problem is that most platforms now declare their clocks
such that asking for the pclk will match the functional clock.

I have a patch which adds dummy pclks to all ARM AMBA using platforms.
This patch comes before the pclk-using patch to so that things
shouldn't break.
