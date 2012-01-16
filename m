From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 17:12:29 +0530
Subject: [PATCH 8/8] dmaengine/dw_dmac: Add support for DMA_SLAVE_CONFIG
In-Reply-To: <7c1e6fd573d5cd348b22f8363c9960fe5efcd658.1326707233.git.viresh.kumar@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <7c1e6fd573d5cd348b22f8363c9960fe5efcd658.1326707233.git.viresh.kumar@st.com>
Message-ID: <4F140D25.1000309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/16/2012 3:20 PM, Viresh KUMAR wrote:
> +	/*
> +	 * Fix sconfig's burst size according to dw_dmac. We need to convert
> +	 * them as: 1 -> 0, 2 -> 1, 4 -> 2, 8 -> 3, 16 -> 4.
> +	 *
> +	 * This can be done by findiding least significant bit set: n & (n - 1)
> +	 */
> +	sconfig->src_maxburst &= sconfig->src_maxburst - 1;
> +	sconfig->dst_maxburst &= sconfig->dst_maxburst - 1;

Perhaps, this looks incorrect. It will always return 0. :(
Can somebody suggest any inbuild function to do this, i think

find_next_bit(sconfig->src_maxburst, sizeof(sconfig->src_maxburst), 0)

will do it.

-- 
viresh
