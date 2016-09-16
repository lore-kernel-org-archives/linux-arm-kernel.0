From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 13:55:18 +0200
Subject: [PATCH v2 1/3] ipmi: add an Aspeed BT IPMI BMC driver
In-Reply-To: <1474022367-21029-2-git-send-email-clg@kaod.org>
References: <1474022367-21029-1-git-send-email-clg@kaod.org>
 <1474022367-21029-2-git-send-email-clg@kaod.org>
Message-ID: <2571846.lBvYOIiu5M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 12:39:25 PM CEST C?dric Le Goater wrote:
> From: Alistair Popple <alistair@popple.id.au>
> 
> This patch adds a simple device driver to expose the iBT interface on
> Aspeed SOCs (AST2400 and AST2500) as a character device. Such SOCs are
> commonly used as BMCs (BaseBoard Management Controllers) and this
> driver implements the BMC side of the BT interface.
> 
> The BT (Block Transfer) interface is used to perform in-band IPMI
> communication between a host and its BMC. Entire messages are buffered
> before sending a notification to the other end, host or BMC, that
> there is data to be read. Usually, the host emits requests and the BMC
> responses but the specification provides a mean for the BMC to send
> SMS Attention (BMC-to-Host attention or System Management Software
> attention) messages.
> 
> For this purpose, the driver introduces a specific ioctl on the
> device: 'BT_BMC_IOCTL_SMS_ATN' that can be used by the system running
> on the BMC to signal the host of such an event.
> 
> The device name defaults to '/dev/ipmi-bt-host'
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
