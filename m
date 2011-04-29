From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Apr 2011 08:55:11 +0530
Subject: [PATCH V3 3/7] dmaengine/dw_dmac: don't call callback routine
	in case dmaengine_terminate_all() is called
In-Reply-To: <20110428171118.GC17290@n2100.arm.linux.org.uk>
References: <cover.1303896566.git.viresh.kumar@st.com>
	<b5e9038ecac3f44d265c7321de551bd9b66cdddd.1303896567.git.viresh.kumar@st.com>
	<20110428171118.GC17290@n2100.arm.linux.org.uk>
Message-ID: <4DBA2F97.7080801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2011 10:41 PM, Russell King - ARM Linux wrote:
>> >  static void
>> > -dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
>> > +dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>> > +		bool callback_required)
> If you're using 'bool' then using 'true' and 'false' with it rather than
> '1' and '0' is a good idea.

Yes, will correct this.

-- 
viresh
