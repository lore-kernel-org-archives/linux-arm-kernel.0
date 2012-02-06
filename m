From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 6 Feb 2012 13:41:40 +0530
Subject: [PATCH V3 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of non-slave transfers
In-Reply-To: <20120202121523.GG889@n2100.arm.linux.org.uk>
References: <cover.1328091915.git.viresh.kumar@st.com>
 <c098ca5959c947b3634555bc7bf4a8b3af82a2ae.1328091915.git.viresh.kumar@st.com>
 <20120202121523.GG889@n2100.arm.linux.org.uk>
Message-ID: <4F2F8B3C.7050107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/2012 5:45 PM, Russell King - ARM Linux wrote:
> I'm still unconvinced that this is anywhere close to correct.
> 
> Look.  DMA engines only automatically unmap when they're being used by the
> async_tx stuff for memcpy's, and RAID computation offload, and the like.
> These work with individual single buffers, not scatterlists.  These will
> not be fragmented.

Got it. You are right.

@Vinod: Please drop this patch.

-- 
viresh
