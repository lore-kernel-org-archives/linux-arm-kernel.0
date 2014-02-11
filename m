From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 11 Feb 2014 12:32:36 -0500
Subject: [PATCH 1/3] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
Message-ID: <52FA5EB4.7080008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 02/11/2014 11:53 AM, Pawel Moll wrote:
> This patch tries to solve that issue in a generic way,
> adding a "populated" flag which is set in the device_node
> structure when a device is being created in the core.
> Later, of_platform_populate() skips such nodes (and
> its children) in a similar way to the non-available ones.

Will there never be a case where it is useful for a parent node to be created
early, but not necessarily the child nodes? Might only skipping nodes
explicitly marked as populated be a more universal solution?

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
