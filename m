From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Jun 2014 13:53:35 +0200
Subject: [PATCH v2 4/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel
 definitions for bindings
In-Reply-To: <538F06CF.5090406@codethink.co.uk>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <3770565.HiyLmu1184@avalon> <538F06CF.5090406@codethink.co.uk>
Message-ID: <1917207.MSyb5W7vbK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wednesday 04 June 2014 12:45:19 Ben Dooks wrote:
> On 04/06/14 12:30, Laurent Pinchart wrote:
> > On Tuesday 03 June 2014 09:53:17 Geert Uytterhoeven wrote:
> >> On Mon, Jun 2, 2014 at 3:52 PM, Ben Dooks wrote:
> >>>> +// FIXME
> >>>> +#define CHCR_RX_8BIT SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_8BIT)
> >>>> +#define CHCR_TX_8BIT SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_8BIT)
> >>>> +#define CHCR_RX_16BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_16BIT)
> >>>> +#define CHCR_TX_16BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_16BIT)
> >>>> +#define CHCR_RX_32BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
> >>>> +#define CHCR_TX_32BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
> >>>> +#define CHCR_RX_256BIT       SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
> >>>> +#define CHCR_TX_256BIT       SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
> >>> 
> >>> I am pretty sure for round-2 we can remove these in favour of a
> >>> table in the driver. The only device that has a non-standard setting
> >>> is the SDHI and that will support 32bit and 256bit transfers.
> >> 
> >> Thanks, I'm eagerly awaiting your next version...
> > 
> > Speaking of that, Ben, do you have a git tree with your latest patches ?
> 
> Not yet, as currently working on sorting out the soc_camera before
> moving back to the DMA. I have a plan, just not had the time to sort
> it out.

I need to start implementing LPAE support for the DMAC using descriptors, and 
I have to decide whether I'll go for a new driver of fix the existing one(s). 
Having access to your code, even if it's work in progress, would be helpful, 
otherwise there will be a high chance of conflicts.

-- 
Regards,

Laurent Pinchart
