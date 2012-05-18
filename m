From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 18 May 2012 17:04:15 +0800
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
In-Reply-To: <CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
 <CAMQu2gzhG4fm-B8mhCkrUjMEkkKR4yDZokvnkChLux8voLUnbw@mail.gmail.com>
 <CACVXFVMm5iasFAaBcFhfZskHFwMXEoO2_riP1renR8a0tP_PNg@mail.gmail.com>
 <CAMQu2gz9SGDwE3p1oREb8h+1RUpd1h6yOEJCRJ52PCSY1w0=yQ@mail.gmail.com>
Message-ID: <CACVXFVOA=EDJR6HqBRRegr13nTnNdjGSvQUwek2jbu41C5euWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 3:43 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:

>> Is the gpmc a shared interrupt line? SHARED is not needed at all for
>> non shared interrupt line in hardware.
>>
> The line is shared.

If so, dev_id should be added. But sorry, could you let me know
what other interrupt sources are shared with the line?

>From 17.3.2 "Interrupt Requests to Cortex-A9 MPU INTC" of OMAP4
TRM, GPMC_IRQ is the only source of MA_IRQ_20 for Cortex-A9 MPU
INTC.  Even though GPMC_IRQ is connected with D_IRQ_59(DSP INTC)
and MA_IRQ_20(MPU INTC), this still means it is not a shared line for
MPU INTC.

Also looks the above is similar for OMAP3.

Correct me if the above is wrong.

Thanks,
--
Ming Lei
