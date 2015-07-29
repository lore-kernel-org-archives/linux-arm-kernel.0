From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 28 Jul 2015 22:08:28 -0700
Subject: [PATCH 02/10] usb: chipidea: define stream mode disable for both
 roles
In-Reply-To: <1438137734-27311-3-git-send-email-peter.chen@freescale.com>
References: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
 <1438137734-27311-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20150729050828.GA5502@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:42:06AM +0800, Peter Chen wrote:
> The system bus and chipidea IP have different limitations for
> both host and device mode.
> For example, with below errata, we need to enable SDIS(Stream Disable Mode)
> at host mode. But we don't want it for device mode at the same system.
> 
> TAR 9000378958
> Title: Non-Double Word Aligned Buffer Address Sometimes Causes Host to Hang on OUT Retry
> Impacted Configuration: Host mode, all transfer types
> Description:
> The host core operating in streaming mode may under run while sending the data packet of an OUT transaction. This under run can occur if there are unexpected system delays in fetching the remaining packet data from memory. The host forces a bad CRC on the packet, the device detects the error and discards the packet. The host then retries a Bulk, Interrupt, or Control transfer if an under run occurs according to the USB specification.

<snip>

Properly format this huge wall of text please, don't commit this as-is.

thanks,

greg k-h
