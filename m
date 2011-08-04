From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 15:11:29 +0530
Subject: [PATCH V3 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <1312447973.1539.24.camel@vkoul-udesk3>
References: <cover.1312190881.git.viresh.kumar@st.com>	
	<cbf7119fa968fa54077729aabf1ecca5d21db629.1312190881.git.viresh.kumar@st.com>
	<1312447973.1539.24.camel@vkoul-udesk3>
Message-ID: <4E3A6949.2050109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2011 02:22 PM, Koul, Vinod wrote:
> i dont think pm_runtime_put_sync() is the right thing to do here. This
> will call your suspend and return after suspend has been called. This
> will delay your probe completion and have impact on system boot time,
> this is a very wrong approach.
> Please move this to _put, so that suspend will be called asynchronously
> 
> Also while at it why should you require all the _put calls to be _sync
> type?

That was a mistake, and i already fixed this in a reply to Russell's mail
today.

-- 
viresh
