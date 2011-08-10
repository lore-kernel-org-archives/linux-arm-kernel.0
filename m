From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 17:16:09 +0530
Subject: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg than
	required.
In-Reply-To: <4E426EB6.9020408@ru.mvista.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
	<4E426EB6.9020408@ru.mvista.com>
Message-ID: <4E426F81.5080606@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 05:12 PM, Sergei Shtylyov wrote:
>> > -	pages = (pl022->cur_transfer->len>>  PAGE_SHIFT) + 1;
>> > +	pages = ((pl022->cur_transfer->len + (1 << PAGE_SHIFT) - 1)
>> > +			>>  PAGE_SHIFT);
>     No need for parens around the rvalue.

Oops, that was a mistake. Anyway i have send V3 for the same and this issue
is not present anymore.

-- 
viresh
