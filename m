From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Oct 2016 12:27:23 +0530
Subject: [PATCH V6 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <37baf7db-1e14-4027-9397-70649e8fa946@codeaurora.org>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
 <20161020094838.GY2467@localhost>
 <e3cbd6a2-7fac-98ec-74ea-0be88075663c@codeaurora.org>
 <20161020164321.GZ2467@localhost>
 <a4c95bd6-d760-1f02-bbb1-89538037d41e@codeaurora.org>
 <37baf7db-1e14-4027-9397-70649e8fa946@codeaurora.org>
Message-ID: <20161021065723.GA2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 02:55:23PM -0700, Sinan Kaya wrote:
> Hi Vinod,
> 
> On 10/20/2016 10:34 AM, Sinan Kaya wrote:
> > On 10/20/2016 9:43 AM, Vinod Koul wrote:
> >>> slave-dma       git://git.infradead.org/users/vkoul/slave-dma.git (fetch)
> >>>> slave-dma       git://git.infradead.org/users/vkoul/slave-dma.git (push)
> >> You seem to have missed topic/qcom which I pushed last night. next would have worked too!!
> >>
> > 
> > OK. Let me pick that up and test.
> > 
> 
> It looks like patches were applied out of order.

When applying, if I get a conflict I try to skip them. Typically subsequent
patches fail, sometimes they apply. I think couple of them did in this case

It built for me, 0day also gave me success report, so unless we have bisect
regression, I would like rest of the patches on top of this please..

> -rw-rw-r-- 1 okaya users 8176 Oct 20 17:44 0010-dmaengine-qcom_hidma-add-MSI-support-for-interrupts.patch
> -rw-rw-r-- 1 okaya users 1175 Oct 20 17:44 0009-dmaengine-qcom_hidma-break-completion-processing-on-.patch
> -rw-rw-r-- 1 okaya users 4773 Oct 20 17:44 0008-dmaengine-qcom_hidma-protect-common-data-structures.patch
> -rw-rw-r-- 1 okaya users 2752 Oct 20 17:44 0007-dmaengine-qcom_hidma-add-a-common-API-to-setup-the-i.patch
> -rw-rw-r-- 1 okaya users 3225 Oct 20 17:44 0006-dmaengine-qcom_hidma-bring-out-interrupt-cause.patch
> -rw-rw-r-- 1 okaya users 4284 Oct 20 17:44 0005-dmaengine-qcom_hidma-make-pending_tre_count-atomic.patch
> -rw-rw-r-- 1 okaya users 1090 Oct 20 17:44 0004-dmaengine-qcom_hidma-configure-DMA-and-MSI-for-OF.patch
> -rw-rw-r-- 1 okaya users  959 Oct 20 17:44 0003-of-irq-make-of_msi_configure-accessible-from-modules.patch
> -rw-rw-r-- 1 okaya users 1558 Oct 20 17:44 0002-Documentation-DT-qcom_hidma-correct-spelling-mistake.patch
> -rw-rw-r-- 1 okaya users 1588 Oct 20 17:44 0001-Documentation-DT-qcom_hidma-update-binding-for-MSI.patch
> 
> This is the commit order in topic/dma branch. I added <<< for the patches missing below.
> 
> <<< 0010-dmaengine-qcom_hidma-add-MSI-support-for-interrupts.patch
> <<< 0009-dmaengine-qcom_hidma-break-completion-processing-on-.patch
> 
> fc73796 dmaengine: qcom_hidma: break completion processing on error
> 
> <<< 0008-dmaengine-qcom_hidma-protect-common-data-structures.patch
> 
> d3eab50 dmaengine: qcom_hidma: add a common API to setup the interrupt
> 
> <<< 0006-dmaengine-qcom_hidma-bring-out-interrupt-cause.patch
> <<< 0005-dmaengine-qcom_hidma-make-pending_tre_count-atomic.patch
> 
> 9da0be8 dmaengine: qcom_hidma: configure DMA and MSI for OF
> 5282c18 of: irq: make of_msi_configure accessible from modules
> 13af1c8 Documentation: DT: qcom_hidma: correct spelling mistakes
> ef6661b Documentation: DT: qcom_hidma: update binding for MSI
> 
> I also looked at the binary contents of the patches in topic/dma with what I posted
> on v6. They match excluding your Signed off lines.


-- 
~Vinod
