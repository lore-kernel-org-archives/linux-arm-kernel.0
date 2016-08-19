From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 18 Aug 2016 23:26:28 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <20160819024853.GR9681@localhost>
References: <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160808090203.GY9681@localhost>
 <21475c6e-a5f8-5125-3998-f3995ce67c4d@codeaurora.org>
 <20160810172805.GH9681@localhost>
 <d09ebb5f-99ea-a4e9-da9c-693be89c7cd4@codeaurora.org>
 <20160819024853.GR9681@localhost>
Message-ID: <8c096fee-9749-a7df-7e04-25d21c0ea9ac@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2016 10:48 PM, Vinod Koul wrote:
>> Keep a size limited list with error cookies and flush them in terminate all?
> I think so, terminate_all anyway cleans up the channel. Btw what is the
> behaviour on error? Do you terminate or somthing else?
> 

On error, I flush all outstanding transactions with an error code and I reset
the channel. After the reset, the DMA channel is functional again. The client
doesn't need to shutdown anything.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
