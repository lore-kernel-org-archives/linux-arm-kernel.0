From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 2 Sep 2010 23:41:56 +0200
Subject: invalid address returned by usb_alloc_coherent on dockstar
In-Reply-To: <20100902185744.GB26319@n2100.arm.linux.org.uk>
References: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu>
	<20100902163019.GA9983@n2100.arm.linux.org.uk>
	<65B450424E3DC742AA18F68E1AFB214003A59142@EX06.ad.tulane.edu>
	<20100902185744.GB26319@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinz1q77F_V1As2Ob7acY_PS2xpJ1pDRwuvJOk7d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> That's where it's going wrong. ?Buffers allocated by dma_alloc_coherent()
> are already DMA coherent and must not be passed to dma_map_single(). ?I
> believe USB has some way to be told that the buffer is already suitable
> for DMA without needing additional handling.

Yes,
setting
urb->transfer_flags  = URB_NO_TRANSFER_DMA_MAP
will do this

Regards,

Martin
