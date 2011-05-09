From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 9 May 2011 13:46:27 +0530
Subject: [PATCH V4 3/5] dmaengine/dw_dmac: Divide one sg to many desc,
	if sg len is greater than DWC_MAX_COUNT
In-Reply-To: <1304921462.32447.35.camel@vkoul-udesk3>
References: <cover.1304596524.git.viresh.kumar@st.com>	
	<f3150fa0fb160c70760b95ac72423ebba354f188.1304596524.git.viresh.kumar@st.com>	
	<1304918425.32447.20.camel@vkoul-udesk3> <4DC783A9.5060802@st.com>	
	<1304920041.32447.33.camel@vkoul-udesk3> <4DC78ABB.2030800@st.com>
	<1304921462.32447.35.camel@vkoul-udesk3>
Message-ID: <4DC7A2DB.3040601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2011 11:41 AM, Koul, Vinod wrote:
> On Mon, 2011-05-09 at 12:03 +0530, viresh kumar wrote:
>> On 05/09/2011 11:17 AM, Koul, Vinod wrote:
>>> Ah, then there is another todo for this driver. Move from chan->private
>>> to DMA_SLAVE_CONFIG.
>>>
>>> struct dma_slave_config has dedicated fields for both source and
>>> destination widths, src_addr_width & dst_addr_width please use them...
>>> You should pass this structure to device control API as:
>>> dmaengine_device_control(
>>> 	chan, DMA_SLAVE_CONFIG, (unsigned long)&slave_config);
>>
>> As soon as i get some time, will study & implement this.
>> For now, please push this patchset (if it looks fine).
>>
> rest looks OK. Please fix the patch1.
> 
> 

I am resending all 5 patches, so that they get rebased cleanly.

-- 
viresh
