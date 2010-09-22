From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Wed, 22 Sep 2010 11:02:08 +0530
Subject: [PATCH] mmc: failure of block read wait for long time
In-Reply-To: <20100920133703.GC30793@n2100.arm.linux.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026ED@dbde02.ent.ti.com>
	<4C8A19E7.30706@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
	<4C8A2C5D.2050408@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
	<4C971320.7050906@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
	<4C974A5D.5050608@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
	<4C975CFB.6070907@nokia.com>
	<20100920133703.GC30793@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, September 20, 2010 7:07 PM
> To: Adrian Hunter
> Cc: Ghorai, Sukumar; linux-mmc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> On Mon, Sep 20, 2010 at 04:09:15PM +0300, Adrian Hunter wrote:
> > The SD/MMC protocol does not indicate which sector has the error.
> > There is no possibility of trying the ith+1-segment because i is
> > unknown.
> 
> Not entirely true.
> 
> I seem to remember that the MMC protocol (and probably SD protocol)
> provides an ack at the end of each data block to say whether the data
> block was correct or not.
> 
> Some hosts tell you when they receive this ack, and you can track how
> many blocks have been successfully read without error.  The ARM MMCI
> primecell does this.
> 
> However, some hosts don't give you this information, in which case you
> don't know where the error occurred in the read - so when a read fails,
> you can only safely report that no bytes were read successfully.  This
> means that even if the error was on the last block, there's no way to
> know this.
[Ghorai]
Would you please review and merge this patch [1] (attached too)?
[1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmc-failure-of-block-read-wait-for-long-time.patch
Type: application/octet-stream
Size: 1114 bytes
Desc: 0001-mmc-failure-of-block-read-wait-for-long-time.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100922/ee9f688f/attachment.obj>
