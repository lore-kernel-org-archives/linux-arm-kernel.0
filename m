From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Apr 2017 16:30:36 +0530
Subject: [PATCH v4 2/3] Broadcom USB DRD Phy driver for Northstar2
In-Reply-To: <1490704052-11314-3-git-send-email-raviteja.garimella@broadcom.com>
References: <1490704052-11314-1-git-send-email-raviteja.garimella@broadcom.com>
 <1490704052-11314-3-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <8aa2cc42-6fdc-5574-4449-f05f6d5cbd38@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 28 March 2017 05:57 PM, Raviteja Garimella wrote:
> This is driver for USB DRD Phy used in Broadcom's Northstar2
> SoC. The phy can be configured to be in Device mode or Host
> mode based on the type of cable connected to the port. The
> driver registers to  extcon framework to get appropriate
> connect events for Host/Device cables connect/disconnect
> states based on VBUS and ID interrupts.

$patch should be phy: phy-bcm-ns2-usbdrd: USB DRD Phy driver for Broadcoms
Northstar2.

Sorry for not letting you know this earlier. But I feel the design of the
driver should be changed. Extcon shouldn't be used here. The extcon
notifications should be sent to the consumer driver and the consumer driver
should be responsible for invoking the phy ops.

The phy ops being invoked during extcon events doesn't look right.

Thanks
Kishon
