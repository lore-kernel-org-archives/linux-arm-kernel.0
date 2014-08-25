From: tj@kernel.org (Tejun Heo)
Date: Mon, 25 Aug 2014 15:30:02 -0400
Subject: [PATCH v8 3/3] ahci_xgene: Fix the link down in first attempt
 for the APM X-Gene SoC AHCI SATA host controller driver.
In-Reply-To: <1408819047-17224-4-git-send-email-stripathi@apm.com>
References: <1408819047-17224-1-git-send-email-stripathi@apm.com>
 <1408819047-17224-4-git-send-email-stripathi@apm.com>
Message-ID: <20140825193002.GC21688@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 12:07:27AM +0530, Suman Tripathi wrote:
> This patch addresses two HW erratas as described below by retrying the
> COMRESET:
> 
> 1. During speed negotiation, controller is not able to detect ALIGN
> at GEN3(6Gbps) within 54.6us and results in a timeout. This issue can
> be recovered by issuing a COMRESET.
> 
> 2. Although ALIGN detection is successful, 8b/10b and disparity bit
> errors can occur which result in the signature FIS not received
> successfully by the Host controller. Due to this, the PHY communication
> between the host and drive is not established because of CDR(clock and
> data recovery) circuit doesn't lock. This issue can be recoverd by issuing
> a COMRESET.
> 
> The above retries are issued only if the port status register PXSTATUS
> reports device presence detected but PHY communication not established.
> The maximum retry attempts are 3.

Didn't I ask you to update the comment to explain what's going on?  Or
is the existing comment already sufficient?

Thanks.

-- 
tejun
