From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Aug 2016 10:30:26 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <20160808105026.GA12649@leverpostej>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
 <20160808105026.GA12649@leverpostej>
Message-ID: <20160809093026.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 11:50:26AM +0100, Mark Rutland wrote:
> As Russell pointed out in [2], this is a generic infrastructure problem,
> and there are other systems where HW might not have a self-IPI. I note
> that core code already handles that in some cases, e.g. in
> generic_exec_single where we just disable interrupts and run the work
> locally rather than sending a self-IPI.
> 
> How/where exactly is this self-IPI raised? Can we follow the example of
> generic_exec_single there?

irq_work_queue_on() calls arch_send_call_function_single_ipi() with
no checks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
