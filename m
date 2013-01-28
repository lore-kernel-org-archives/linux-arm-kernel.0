From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 28 Jan 2013 11:32:32 +0800
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and
 vbus connect/disconnect detect
In-Reply-To: <87wqv1bnyd.fsf@ashishki-desk.ger.corp.intel.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
 <87y5fimwma.fsf@ashishki-desk.ger.corp.intel.com>
 <20130125062827.GD29795@nchen-desktop>
 <87wqv1bnyd.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130128033203.GC2673@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:40:10AM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > On Thu, Jan 24, 2013 at 05:25:17PM +0200, Alexander Shishkin wrote:
> 
> What doesn't happen is the reset into device mode (unless you have
> _REGS_SHARED set, which by the way seems a bit misleading) and we're
> still doing nothing till the vbus interrupt comes. So the REGS_SHARED is
> the real problem in this case.

Yes, at imx it sets REGS_SHARD. The REGS_SHARED is needed at below
conditions:
- System boots up with usb device at OTG port using A-plug cable, at this
situation, any gadget initialization should not do any registers operation,
the related functions are udc_start and ci13xxx_start.
- At udc_irq, we do not want any wakeup, id, and host interrupt to call 
internal code.
> 
-- 

Best Regards,
Peter Chen
