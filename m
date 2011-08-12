From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Aug 2011 11:20:20 +0100
Subject: [PATCH kernel-3.0] arm:cache-l2x0: Fix L2 Cache size calculation.
In-Reply-To: <1313142327-18320-1-git-send-email-srinivas.kandagatla@st.com>
References: <1313142327-18320-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20110812102020.GD14904@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 10:45:27AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch fixes L2 Cache size calculations for L2C-210, L2C-310 and
> PL310, by changing the L2X0_AUX_CTRL_WAY_SIZE_MASK from 2 bits to 3
> bits.
> 
> The Auxiliary Control Register for L2C-210, L2C-310 and PL310 has 3bits
> [19:17] for Way size, however the existing code only uses 2 bits to
> get this value. This results in incorrect cachesize calculations.
> 
> I should say this bug does not result in issue but, its just prints
> incorrect values.

It also results in performing operations on the whole cache when we
erroneously decide that the range is big enough (due to l2x0_size being
too small).

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Please can you CC stable on this too?

Will
