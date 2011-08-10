From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 14:35:54 +0530
Subject: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg
	than	required.
In-Reply-To: <20110810085431.GD1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
	<20110810085431.GD1831@n2100.arm.linux.org.uk>
Message-ID: <4E4249F2.1020406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 02:24 PM, Russell King - ARM Linux wrote:
> It would be far better for this to be:
> 
> 	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);
> 
> The compiler will probably optimize it to the same code anyway.

I thought of it too, but missed to update code. Thanks.

-- 
viresh
