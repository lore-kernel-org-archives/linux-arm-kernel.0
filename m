From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 12 Jul 2010 09:53:48 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <4C3A950F.5040900@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<4C3A950F.5040900@st.com>
Message-ID: <AANLkTikuafea-9ca4AdnEEhw2ozyNvcjaSDogb6K39Lh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/12 Viresh KUMAR <viresh.kumar@st.com>:

> This issue is different from the issue i raised which was common to
> all amba devices. This is just for this GPIO driver, we need to enable clk
> before using any gpio pin.

I think what Russell means is that all current clocks looked up by the
drivers are implicitly of types that control output signals to things like
UART RX, SPI out, etc, i.e. clocks that control signals that exit the system.

These are usually fixed, e.g. in ARM Ltd. reference designs there is a
fixed 24MHz clock for all of these.

The clock that controls the internal logic in the PrimeCell itself should
be modeled into the AMBA (PrimeCell) bus abstraction.

Yours,
Linus Walleij
