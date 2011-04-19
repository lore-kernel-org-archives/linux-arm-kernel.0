From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Apr 2011 12:16:43 +0530
Subject: [PATCH 2/6] dmaengine/dw_dmac: Enable resubmission from callback
	routine.
In-Reply-To: <438BB0150E931F4B9CE701519A44630108519E1C1D@bgsmsx502.gar.corp.intel.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
	<cf350c267897bd4eaf5a027c659771eee117ac74.1303123511.git.viresh.kumar@st.com>
	<438BB0150E931F4B9CE701519A44630108519E1BE6@bgsmsx502.gar.corp.intel.com>
	<4DAD2A61.4020406@st.com>
	<438BB0150E931F4B9CE701519A44630108519E1C1D@bgsmsx502.gar.corp.intel.com>
Message-ID: <4DAD2FD3.5010103@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2011 12:03 PM, Koul, Vinod wrote:
> On 04/19/2011 11:53 AM, viresh kumar wrote:
>> On 04/19/2011 11:42 AM, Koul, Vinod wrote:
>>> On 04/18/2011 04:20 PM, viresh kumar wrote:
>> Vinod,
>>
>> I initiated this discussion few days back on a separate thread:
>>
>> http://www.spinics.net/lists/arm-kernel/msg121139.html
>>
>> And so implemented this.
> Ahhh, on the road, catching up on email...
> 
> This was a dma engine requirement, not absolute for slave-dma.
> But would be good idea to resist this. What is your reason for this?

Mainline drivers using dmaengine are already submitting new transfers from
callback routines. For example: amba-pl011.
And i have to use pl011 with DMA, so faced this issue in dw_dmac.

-- 
viresh
