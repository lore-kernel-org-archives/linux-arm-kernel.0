From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 14 May 2016 11:55:16 +0530
Subject: [PATCH V18 0/3] dmaengine: add Qualcomm Technologies HIDMA driver
In-Reply-To: <1462076728-14367-1-git-send-email-okaya@codeaurora.org>
References: <1462076728-14367-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20160514062516.GL2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01, 2016 at 12:25:25AM -0400, Sinan Kaya wrote:
> The Qualcomm Technologies HIDMA device has been designed
> to support virtualization technology. The driver has been
> divided into two to follow the hardware design.
> 
> 1. HIDMA Management driver
> 2. HIDMA Channel driver
> 
> Each HIDMA HW consists of multiple channels. These channels
> share some set of common parameters. These parameters are
> initialized by the management driver during power up.
> Same management driver is used for monitoring the execution
> of the channels. Management driver can change the performance
> behavior dynamically such as bandwidth allocation and
> prioritization in the future.
> 
> The management driver is executed in host context and
> is the main management entity for all channels provided by
> the device.
> 
> ------------------------
> What's new
> ------------------------
> - Get rid of hidma_ll_resume function
> - Rename hidma_ll_pause to hidma_ll_disable
> - Remove tx_status_list and attach the err_code and err_info to the TRE
> - Create a hidma_handle_tre_completion function to make error path and
>   success path common.
> - More style corrections

Applied, thanks

-- 
~Vinod
