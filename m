From: GKing@nvidia.com (Gary King)
Date: Thu, 29 Jul 2010 08:46:15 -0700
Subject: [PATCH 1/2] [ARM] dmabounce: add support for low bitmasks in
	dmabounce
In-Reply-To: <20100729085056.GA14880@n2100.arm.linux.org.uk>
References: <1280365067-21102-1-git-send-email-gking@nvidia.com>
	<1280365067-21102-2-git-send-email-gking@nvidia.com>,
	<20100729085056.GA14880@n2100.arm.linux.org.uk>
Message-ID: <A0A1E7539300DF49AA383E614C7827BC04D9B17AA8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

>> some systems have devices which require DMA bounce buffers due to
>> alignment restrictions rather than address window restrictions.

> Why can't you arrange for the originally allocated buffer to have the
> necessary alignment?  What kind of devices have this problem?  Are
> there cases where the alignment is greater than the L1 cache line size?

The USB host controller in Tegra SoCs needs the DMA start address to be
burst-size aligned (incidentally, this is the L1 cache size). For USB
networking, the buffers that are being DMA'd are just the skbuffs, and
this does not ensure sufficient alignment for the host controller.

- Gary
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
