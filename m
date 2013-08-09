From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 9 Aug 2013 19:46:00 +0800
Subject: [PATCH v14 11/12] usb: chipidea: udc: misuse flag
 CI_HDRC_REGS_SHARED and CI_HDRC_PULLUP_ON_VBUS
In-Reply-To: <874nazathc.fsf@ashishki-desk.ger.corp.intel.com>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
 <1375432445-31918-12-git-send-email-peter.chen@freescale.com>
 <874nazathc.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130809114559.GC24763@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 04:23:11PM +0300, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > CI_HDRC_REGS_SHARED stands for the controller registers is shared
> > with other USB drivers, if all USB drivers are at chipidea/, it doesn't
> > needed to set.
> 
> We still have the msm driver that uses REGS_SHARED.
> 

Yes, I have considered it. At udc interrupt handler, the REGS_SHARED
is still used. The msm set both CI_HDRC_REGS_SHARED and CI_HDRC_PULLUP_ON_VBUS.

> > CI_HDRC_PULLUP_ON_VBUS stands for pullup dp when the vbus is on. This
> > flag doesn't need to set if the vbus is always on for gadget
> > since dp has always pulled up after the gadget has initialized.
> 
> Didn't we agree at some point to get rid of this flag altogether once we
> have proper VBUS detection?

Yes, we can delete it now, the reason why I haven't remove it is:
I met some use cases that the vbus is always on recently,
no connection/disconnection. Eg, the USB audio device connects
to Apple Sound machine, the vbus is the power of the device system.

I checked the code just now again, we can cover such kind of case.

-- 

Best Regards,
Peter Chen
