From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 23 Aug 2011 09:52:49 +0530
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len greater
	than one for slave transfers
In-Reply-To: <20110821083306.GA12028@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>
	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>
Message-ID: <4E532B19.6000103@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/2011 2:03 PM, Russell King - ARM Linux wrote:
>> > I am not sure if i get this completely. In memcpy, we still don't support
>> > more than one sg. We have created a new member in txd, which keeps track of
>> > data (addresses, len).
> Yes, but we shouldn't need to translate it into any kind of scatterlist.
> 

Ok. I way out is keeping two separate variables in txd, list for slave transfers,
and pointer to single element for memcpy. And that looks to be even bad to me.
Why waste memory, for second variable. Or create union of both.

One more thing, we can actually have scatter gather in memcpy too in future. This will be
helpful then also. But surely that's something not implemented currently.

-- 
viresh
