From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 1 Jun 2018 09:34:04 -0400
Subject: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
In-Reply-To: <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
 <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
 <51bb7b82-c4a1-435c-7668-639db96d76e1@finnie.org>
 <af772e6434e645f4a42d22821442a3bd@microsemi.com>
 <3ebb873ea4658275e7fa89c01cd8bfe1@codeaurora.org>
Message-ID: <fe49b9b4-5e15-b0ae-59c3-33b5a31eeb9c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2018 9:08 PM, okaya at codeaurora.org wrote:
> I have seen that shutdown() is also called from remove().
> 
> remove() is supposed to do a safe cleanup too. If it is leaving the hw in inconsistent state even though it is c lling shutdown , it is yet another bug.

Let's try to be constructive. I'll post a patch with the pci_disable added to shutdown
only as in my original proposal.

Somebody can deal with remove another day.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
