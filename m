From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 29 Jul 2011 18:13:47 +0530
Subject: [PATCH 13/18] dmaengine/amba-pl08x: Align lli_len to
	max(src.width, dst.width)
In-Reply-To: <afe9e5154d96c0f44c64c411c98b5db75969db6c.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<afe9e5154d96c0f44c64c411c98b5db75969db6c.1311936524.git.viresh.kumar@st.com>
Message-ID: <1311943427.1536.551.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> Currently lli_len is aligned to min of two widths, which looks to be incorrect.
> Instead it should be aligned to max of both widths.
hmmm, not sure I follow you...
In previous patch you said

"max_bytes_per_lli = bd.srcbus.buswidth *
PL080_CONTROL_TRANSFER_SIZE_MASK;
This is confirmed by ARM support guys."

So why should lli_len be related to max of both widths?

-- 
~Vinod
