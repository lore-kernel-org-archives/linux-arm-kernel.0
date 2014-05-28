From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:52:10 -0700
Subject: [PATCH 08/12] scsi/NCR5380: adopt dprintk()
In-Reply-To: <20140318004214.992467108@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004214.992467108@telegraphics.com.au>
Message-ID: <20140528095210.GH26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:20AM +1100, Finn Thain wrote:
> All NCR5380 drivers already include the NCR5380.h header. Better to
> adopt those macros rather than have three variations on them.
> 
> Moreover, the macros in NCR5380.h are preferable because the atari_NCR5380
> and sun3_NCR5380 versions are inflexible. For example, they can't accomodate
> dprintk(NDEBUG_MAIN | NDEBUG_QUEUES, ...)
> 
> Replace the *_PRINTK macros from atari_NCR5380.h and sun3_NCR5380.h with
> the equivalent macros from NCR5380.h.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
