From: leoli@freescale.com (Li Yang)
Date: Thu, 13 Aug 2015 15:58:01 -0500
Subject: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 3:56 AM, Yuan Yao <yao.yuan@freescale.com> wrote:
> This add power management suspend/resume support for the fsl-edma
> driver.
>
> eDMA acted as a basic function used by others. What it needs to do is
> the two steps below to support power management.
>
> In fsl_edma_suspend_late:
> Check whether the DMA chan is idle and if it is not idle, stop PM
> operation.

You should try to quiesce the device on suspend instead of depending
on itself to be happen in idle and failing if it is not.

Regards,
Leo
