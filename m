From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 27 Jan 2017 11:07:53 +0200
Subject: [PATCH linux-next v2 1/1] usb: gadget: udc: atmel: Update
 endpoint allocation scheme
In-Reply-To: <84fe6fa4-7cf7-22cb-b4b7-47e2cb202a68@atmel.com>
References: <1485182759-17165-1-git-send-email-cristian.birsan@microchip.com>
 <1485182759-17165-2-git-send-email-cristian.birsan@microchip.com>
 <84fe6fa4-7cf7-22cb-b4b7-47e2cb202a68@atmel.com>
Message-ID: <87inp098gm.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Le 23/01/2017 ? 15:45, cristian.birsan at microchip.com a ?crit :
>> From: Cristian Birsan <cristian.birsan@microchip.com>
>> 
>> Update atmel udc driver with a new enpoint allocation scheme. The data
>> sheet requires that all endpoints are allocated in order.
>
> Pieces of information from the cover letter could have been added here.

yup, that's what I did:

commit 741d2558bf0aa8da9c0834ad43e1b9a1b16aa515
Author: Cristian Birsan <cristian.birsan@microchip.com>
Date:   Mon Jan 23 16:45:59 2017 +0200

    usb: gadget: udc: atmel: Update endpoint allocation scheme
    
    This patch updates the usb endpoint allocation scheme for atmel usba
    driver to make sure all endpoints are allocated in order. This
    requirement comes from the datasheet of the controller.
    
    The allocation scheme is decided by fifo_mode parameter. For fifo_mode =
    0 the driver tries to autoconfigure the endpoints fifo size. All other
    modes contain fixed configurations optimized for different purposes. The
    idea is somehow similar with the approach used on musb driver.
    
    Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
    Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

But seems like we will need a fixup patch during v4.11-rc?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/2e9ab65b/attachment.sig>
