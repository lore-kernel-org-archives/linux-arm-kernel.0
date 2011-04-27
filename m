From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 27 Apr 2011 09:17:07 +0530
Subject: [PATCH 1/6] dmaengine/dw_dmac: Replace spin_lock_bh with	irqsave
	variants
In-Reply-To: <20110426203306.GC17290@n2100.arm.linux.org.uk>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
	<4DAD2AE9.7060106@st.com>
	<20110426203306.GC17290@n2100.arm.linux.org.uk>
Message-ID: <4DB791BB.8050207@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 02:03 AM, Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2011 at 11:55:45AM +0530, viresh kumar wrote:
>> This must have been added in dw_dma_chan instead :(
>> Will resend it.
> 
> Even that doesn't work.  It has to be a local variable.

I assumed that flags wouldn't be updated if lock is already taken by some other thread.
In which case global flags would have worked fine.
But as i see now, that's incorrect. Flags is always changed, whether or not lock is taken.

Will resend it again.

-- 
viresh
