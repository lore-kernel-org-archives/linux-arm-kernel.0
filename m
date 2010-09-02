From: maclaren@tulane.edu (MacLaren, James M)
Date: Thu, 2 Sep 2010 18:21:04 -0500
Subject: invalid address returned by usb_alloc_coherent on dockstar
References: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu><20100902163019.GA9983@n2100.arm.linux.org.uk><65B450424E3DC742AA18F68E1AFB214003A59142@EX06.ad.tulane.edu><20100902185744.GB26319@n2100.arm.linux.org.uk>
	<AANLkTinz1q77F_V1As2Ob7acY_PS2xpJ1pDRwuvJOk7d@mail.gmail.com>
Message-ID: <65B450424E3DC742AA18F68E1AFB2140015BDF4C@EX06.ad.tulane.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> That's where it's going wrong. ?Buffers allocated by dma_alloc_coherent()
>> are already DMA coherent and must not be passed to dma_map_single(). ?I
>> believe USB has some way to be told that the buffer is already suitable
>> for DMA without needing additional handling.

>Yes,
>setting
>urb->transfer_flags  = URB_NO_TRANSFER_DMA_MAP
>will do this

>Regards,

>Martin


Russell and Martin

THANKS!!! That solved it.  I also saw in the linux device drivers 3rd edition that they added 

urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

after the call to usb_fill_bulk_urb

I did this and now it captures from /dev/video0 just fine.

If you ever find yourself in New Orleans I'll buy you a beer!

Thanks,
James
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100902/ddb82bf2/attachment-0001.html>
