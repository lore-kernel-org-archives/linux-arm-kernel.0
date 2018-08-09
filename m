From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Aug 2018 11:23:40 +0200
Subject: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
In-Reply-To: <1533806000.3347.6.camel@mtksdaap41>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
 <20180808205752.llowh4bvu2wkuhga@ninjato>
 <1533806000.3347.6.camel@mtksdaap41>
Message-ID: <20180809092340.rm4ywre543hpejne@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I believe the reason for these api is because some arch changed to can
> not do DMA on stack recently. Maybe we should have dma_mapping to bounce

It is not only arch dependent. You can enable virtual stacks in Kconfig,
too.

> buffer like it bounce un-dma-able address for those arch? or we should
> have a common driver API for this, not just for i2c?

I gave a talk about this problem recently and everyone in the room
agreed the best thing would be to have annotated buffers which can be
used kernel-wide. Someone mentioned DMABUF could be a candidate, but I
haven't looked further into that.

So, yes, a bigger solution is needed but I don't see that coming soon,
so I implemented the I2C part for better safety now. I'd be happy to
remove all that again once we have the annotated buffers. But it is an
effort...

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180809/c58411fe/attachment.sig>
