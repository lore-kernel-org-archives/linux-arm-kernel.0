From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 13 Aug 2013 13:10:02 -0700 (PDT)
Subject: [PATCH 12/18] ARM: s3c64xx: Add support for DMA using generic
 amba-pl08x driver
In-Reply-To: <20130813175251.GC6427@sirena.org.uk>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-13-git-send-email-tomasz.figa@gmail.com>
 <20130813175251.GC6427@sirena.org.uk>
Message-ID: <4262768.VLqddFvVic@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of August 2013 18:52:51 Mark Brown wrote:
> On Sun, Aug 11, 2013 at 07:59:24PM +0200, Tomasz Figa wrote:
> > +#define pl330_filter pl08x_filter_id
> 
> So, this is pretty fun and probably not going to play too nicely for
> multiplatform kernels...

Yes, this is really funny and only shows the brokenness of current channel 
filtering mechanism used in DMA engine subsystem. Fortunately this is 
quite irrelevant to multiplatform kernels, because no users of it will be 
compiled in, since it's used only for legacy (non-DT) channel filtering.

Anyway, I would happily redesign and rewrite the DMA engine channel 
matching completely to make it much more sane, but I guess I would need an 
ack from Vinod and Dan to do it.

Best regards,
Tomasz
