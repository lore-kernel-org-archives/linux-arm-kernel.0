From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Wed, 2 Dec 2009 16:58:23 -0200
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin,

On 12/2/09, Valentin Longchamp <valentin.longchamp@epfl.ch> wrote:
> On various mxc boards, the intial ULPI reads resulted in a timeout
> which prevented the transceiver to be identified and thus the ehci
> device to be probed.
>
> Initializing the hardware lines connected to the transceiver (through
> pdata->init call) before actually enabling clocks and configuring
> registers in the devices fixes this problem.
>

Unfortunately it didn't solve the issues on my not working board.

Also I noticed on "working" board the PSW_N pin is not going to low.
I created an ulpi with USB_OTG_DRV_VBUS and USB_OTG_DRV_VBUS_EXT.

Then I forced VBUS to high directly (connecting it to VCC, I know it
is very *dangerous*) in order power on a mouse connected to USB port.
It detected a device was attached, but didn't enumerate it:

mx27# usb 2-1: new low speed USB device using mxc-ehci and address 2
hub 2-0:1.0: unable to enumerate USB device on port 1

What you think about it?

Best Regards,

Alan
