From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 22:02:21 +0530
Subject: [PATCH V14 5/9] dma: qcom_hidma: implement lower level hardware
 interface
In-Reply-To: <56E2EC1C.6040107@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-6-git-send-email-okaya@codeaurora.org>
 <20160311020650.GG11154@localhost>
 <56E2EC1C.6040107@codeaurora.org>
Message-ID: <20160311163221.GC13211@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 11:02:36AM -0500, Sinan Kaya wrote:
> > These are rest here are not namespace properly...
> 
> If I understood it right, you want me to prefix them with as HIDMA_xyz.
> Correct?

Yes..

> >> +	/* copy the TRE into its location in the TRE ring */
> >> +	spin_lock_irqsave(&lldev->lock, flags);
> >> +	tre->tre_index = lldev->tre_write_offset / TRE_SIZE;
> >> +	lldev->pending_tre_list[tre->tre_index] = tre;
> >> +	memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
> >> +	       TRE_SIZE);

This one

> >> +	lldev->tx_status_list[tre->idx].err_code = 0;
> >> +	lldev->tx_status_list[tre->idx].err_info = 0;
> >> +	tre->queued = 1;
> >> +	lldev->pending_tre_count++;
> 
> Is this the only one without alignment? I couldn't understand what you mean by 
> above one?

quoting Coding Style:

Statements longer than 80 columns will be broken into sensible chunks, unless
exceeding 80 columns significantly increases readability and does not hide
information. Descendants are always substantially shorter than the parent and
are placed substantially to the right.


> 
> >> +	lldev->tre_write_offset = (lldev->tre_write_offset + TRE_SIZE)
> >> +	    % lldev->tre_ring_size;
> > 
> > These and above one should be right justfied per coding style

-- 
~Vinod
