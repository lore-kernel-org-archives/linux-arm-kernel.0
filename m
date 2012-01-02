From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 02 Jan 2012 16:55:35 +0530
Subject: [PATCH] dmaengine/dw_dmac: Add support for device_prep_dma_sg
In-Reply-To: <4F0192F2.3010506@st.com>
References: <1323766064-13425-1-git-send-email-pratyush.anand@st.com>
 <1324655898.1633.11.camel@vkoul-udesk3>  <4F0192F2.3010506@st.com>
Message-ID: <1325503535.1540.17.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-01-02 at 16:50 +0530, Pratyush Anand wrote:
> On 12/23/2011 9:28 PM, Vinod Koul wrote:
> > On Tue, 2011-12-13 at 14:17 +0530, Pratyush Anand wrote:
> >> Memory to memory copy with scatter gather option has been implemented in
> >> this patch. Driver can manage even if number of nodes in src and dst
> >> list is different.
> > The logic looks okay, but it would be great if we could split this
> > prepare here.
> > Possibly later when we have multiple such cases we can create templates
> > for parsing the non linear sg list and create linear lists from it.
> >
> 
> Ok. So you suggest to have one patch with a function to align sglist
> w.r.t length, and to implement this dwc_prep_dma_sg with aligned list only.
IMO that would be a much better approach
> 
> Caller of dwc_prep_dma_sg function will also call something like
> align_sg_list(unaligned_dsgl, unaligned ssgl, aligned dsgl,aligned ssgl);
and this one can be common code in dmaengine

> dwc_prep_dma_sg(chan, aligned dsgl, dnents, aligned ssgl, snents, flag);
> 
> Is that what you suggest? will do that.
> 
> It would be helpful if we can also conclude following discussion.
> https://lkml.org/lkml/2011/12/20/95
> I am waiting for your reply.
Missed that, will check it now


-- 
~Vinod
