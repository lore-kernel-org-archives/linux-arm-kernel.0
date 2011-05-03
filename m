From: hunold@linuxtv.org (Michael Hunold)
Date: Tue, 03 May 2011 08:25:32 +0200
Subject: dma_alloc_writecombine() and MAX_ORDER
In-Reply-To: <20110429142755.GS5126@n2100.arm.linux.org.uk>
References: <4DBAB41D.7030705@linuxtv.org>
	<20110429142755.GS5126@n2100.arm.linux.org.uk>
Message-ID: <4DBF9FDC.6080400@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

on 04/29/2011 04:27 PM Russell King - ARM Linux said the following:
> On Fri, Apr 29, 2011 at 02:50:37PM +0200, Michael Hunold wrote:

>> Now I have a new panel with a higher resolution and more bits-per-pixel.
>> I want to use double-buffering with DirectFB and so my framebuffer size
>> exceeds 4Mb.

> You could try this patch.  It steals the memory for the coherent and
> writecombine memory at boot time, so MAX_ORDER no longer comes into the
> problem.  You may need to define CONSISTENT_WC_SIZE and CONSISTENT_DMA_SIZE
> appropriately to gain sufficient memory.  Note that the sum of those two
> must be a multiple of 2MB, and individually must be a multiple of 1MB.

I really want to try this patch out, but unfortunately, I don't know to
which tree I can apply it to. :-(

I'm working on a tree which is based on vanilla 2.6.38 and has the
additions for the platform I'm working with, but there the patch won't
apply cleanly.

The tree can be found here
http://git.labs.kernelconcepts.de/?p=topas.git;a=summary

So I thought I should try "devel-stable" from
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git
but there are even more rejects there.

Can you please tell me from which tree you created this patch?

Best regards
Michael.
