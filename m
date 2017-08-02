From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 2 Aug 2017 10:25:22 +0530
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
 <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
 <20170731123157.GJ3053@localhost>
 <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
Message-ID: <20170802045522.GU3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 09:32:50AM +0000, Pierre Yves MORDRET wrote:
> 
> 
> On 07/31/2017 02:31 PM, Vinod Koul wrote:
> > On Wed, Jul 26, 2017 at 07:38:02AM +0000, Pierre Yves MORDRET wrote:
> >>>>>> +
> >>>>>> +#ifndef __DMA_STM32_DMAMUX_H
> >>>>>> +#define __DMA_STM32_DMAMUX_H
> >>>>>> +
> >>>>>> +#if defined(CONFIG_STM32_DMAMUX)
> >>>>>> +int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
> >>>>>
> >>>>> Why do we need a custom API in this case?
> >>>>>
> >>>>
> >>>> This API is called by DMA when a slave is requested by client. DMA can work
> >>>> without DMAMUX this API has been put in place to configure DMAMUX whether client
> >>>> is requesting a DMAMUX Channel instead of a DMA one.
> >>>
> >>> You mean the dmaengine driver right?
> >>>
> >>
> >> Yes. The API is mainly called by "device_config" through out STM32 DMA Driver
> >> when a router is in place for client.
> >> Please refer to Patch 4/5 on this set.
> > 
> > Okay am thinking on why this can't be generic..? An optional router config
> > callback?
> > 
> 
> I would have liked to answer there is a callback within engine but unfortunately
> I didn't figure out one when I did my router's development. I've looked once
> more but again I can't find how to map chanID and request line without custom API.

Yes there is no callback for routers but we can add a generic callback
here to be used. I added Peter for his comments, isn't that something they
need too?

-- 
~Vinod
