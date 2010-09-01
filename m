From: maclaren@tulane.edu (MacLaren, James M)
Date: Wed, 1 Sep 2010 09:48:33 -0500
Subject: invalid address returned by usb_alloc_coherent on dockstar
Message-ID: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been working on getting mythtv to run on my dockstar mostly with
success.  I can record from the hd-homerun a network atsc/qam tv tuner.
I understand from reading mailing list that a usb recorder (HVR-1950)
has been made to work on a sheeva plug.  I am trying to get the
Hauppuage hdpvr to work.  The driver is relatively new but seems to work
stablely on i386 systems.  I am hoping someone can help with the
problem.

 

The call to 

mem = usb_alloc_coherent(dev->udev, dev->bulk_in_size, GFP_KERNEL,

&urb->transfer_dma);

 

in hdvpr-video.c

 

Returns an address ffc11c00 which is not valid when I check it with
virt_addr_valid.  So the driver then exits gracefully later on.

 

Other allocated addresses seem fine.  I am unsure how to debug this.  I
have adjusted the value of dev->bulk_in_size from 8192 to 512 and still
get the same problem.  I have changed the memory flag from GFP_KERNEL to
GFP_KERNEL | GFP_DMA but that didn't help.  Any pointers/advice would be
appreciated.  

 

Maybe the dockstar has too little memory to make this work.  I am using
kernel 2.6.35-1 from with-sheeva compiled with that .config with the
change made to compile the hdpvr.ko module.

 

 

Thanks

James

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100901/07cc89bc/attachment.html>
