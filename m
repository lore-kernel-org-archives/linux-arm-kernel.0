From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 18 Jan 2012 15:24:44 +0530
Subject: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
In-Reply-To: <20120118093620.GC1068@n2100.arm.linux.org.uk>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk>
Message-ID: <4F1696E4.9070806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/18/2012 3:06 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 02:41:55PM +0530, Viresh Kumar wrote:
> NAK.  For reasons stated previously and subsequently ignored.
> .
> 

On 1/18/2012 3:05 PM, Russell King - ARM Linux wrote:
>> > You implemented similar stuff in amba-pl08x :) .
>> > 
>> > if (!plchan->slave)
>> > 	pl08x_unmap_buffers(txd);
> Take a look at that.  "If *NOT* slave, unmap the buffers".

[Following is picked from current implementation of dw_dmac:]

	if (!dwc->chan.private) {
		struct device *parent = chan2parent(&dwc->chan);
		if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {

Sorry, I missed the most straight forward looking code. :(
Actually, dw_dmac is also doing the same, i.e. unmapping only for
non-slave transfers.

The same patch is still applicable, after fixing message subject and log.
I will resend it, with message log fixed, once i get more feedbacks on V2.

-- 
viresh
