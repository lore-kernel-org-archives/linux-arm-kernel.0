From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 6 Nov 2009 01:11:54 +0100
Subject: [PATCH 2/3] ARM: MXC: mxcmmc: Fix max_seg_size assignment
In-Reply-To: <20091105173251.GF21681@n2100.arm.linux.org.uk>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
	<1257441216-19604-2-git-send-email-daniel@caiaq.de>
	<1257441216-19604-3-git-send-email-daniel@caiaq.de>
	<20091105173251.GF21681@n2100.arm.linux.org.uk>
Message-ID: <20091106001153.GC14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 05:32:51PM +0000, Russell King - ARM Linux wrote:
> Err "fix" ?  No, that's not what this is.
> 
> max_seg_size is the maximum segment size, not the maximum request size.
> The naming of these comes from the block IO subsystem, so it's a good
> idea to preserve the naming (and therefore the meaning.)
> 
> max_req_size suggests that this parameter indicates the maximum size
> of any single request.  A single request can be made up of multiple
> segments, so clearly this change is misleading.

Well - I considered that a typo only, as the left and right side were
identical:

> > -	mmc->max_seg_size = mmc->max_seg_size;

Other drivers define seg_size = reg_size, and I thought that was what
was intended here.

Daniel
