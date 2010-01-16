From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 16 Jan 2010 13:39:08 +0100
Subject: s3c-hsotg driver problem
Message-ID: <4B51B36C.6040308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to get the USB OTG port working on my device (S3C6410 board), 
but am running into problems.
This board doesn't have a 48Mhz clock, so I set the reference clock in 
the USB PLL to a 12Mhz external crystal (see patch).

Still, I'm having trouble getting it to work; I'm seeing these messages 
(see attachment for full log):

s3c-hsotg s3c-hsotg: s3c_hsotg_rx_data: FIFO 8 bytes on ep0 but no req 
(DxEPCTl=0x00028000)
hub 1-0:1.0: connect-debounce failed, port 2 disabled

This looks like the hardware is configured correctly, but the 
currently-in-use gadget isn't setting up an EP0 RX transfer?
I've tried Mass Storage, serial, Ethernet, ... gadgets and they all give 
the same errors.

Any hints/pointers would be welcome!

Thanks,
Maurus Cuelenaere
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: att1
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100116/16919c45/attachment-0002.el>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: att2
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100116/16919c45/attachment-0003.el>
