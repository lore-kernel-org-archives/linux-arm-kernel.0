From: b-liu@ti.com (Bin Liu)
Date: Mon, 16 May 2016 15:15:12 -0500
Subject: [PATCH v2 2/2] musb: sunxi: Set state to A_WAIT_VRISE when
 enabling Vbus
In-Reply-To: <1463229905-26387-2-git-send-email-hdegoede@redhat.com>
References: <1463229905-26387-1-git-send-email-hdegoede@redhat.com>
 <1463229905-26387-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160516201512.GB9927@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2016 at 02:45:05PM +0200, Hans de Goede wrote:
> When the board is powering attached usb devices via the otg port
> sometimes / on some devices it takes slightly too long for the Vbus
> detection code in phy-sun4i-usb.c to signal that Vbus is high after
> enabling Vbus and the musb hardware signals a MUSB_INTR_VBUSERROR
> interrupt.
> 
> This commit sets the otg state to A_WAIT_VRISE upon enabling Vbus
> making musb_stage0_irq() ignore the first VBUSERR_RETRY_COUNT
> VBUSERROR interrupts, fixing connection issues in these cases.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Bin Liu <b-liu@ti.com>

Regards,
-Bin.
