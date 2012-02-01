From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 01 Feb 2012 14:16:57 +0530
Subject: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
In-Reply-To: <4F28F9D5.6020801@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
 <1326807902.1540.116.camel@vkoul-udesk3> <4F195E4C.6080805@codeaurora.org>
 <1327066287.517.4.camel@vkoul-udesk3> <4F1D4052.3070701@codeaurora.org>
 <1327326713.517.32.camel@vkoul-udesk3> <4F1FFF7E.3000802@codeaurora.org>
 <1327911315.1527.8.camel@vkoul-udesk3> <4F278341.4020600@codeaurora.org>
 <1327990151.1527.80.camel@vkoul-udesk3> <4F28D8A2.9050605@codeaurora.org>
 <1328084998.1610.11.camel@vkoul-udesk3>  <4F28F9D5.6020801@codeaurora.org>
Message-ID: <1328086017.1610.13.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-01 at 14:07 +0530, Ravi Kumar V wrote:
> Our hardware supports single transfer mode,scatter gather mode & box
> mode.
> 
> we are using these dmaengine API's for our HW
> device_prep_memcpy() for single mode.
> device_prep_dma_sg() for sg mode.
> device_prep_interleaved_dma() for box mode.
> 
> We need to pass command configuration parameter to all of the above 
> three modes and it can be possible if extra context parameter is added
> into these API's
but again, is this static fr channel for each transfer. Would you be
able to derive these for non box modes?

-- 
~Vinod
