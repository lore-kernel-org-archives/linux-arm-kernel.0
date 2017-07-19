From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 19 Jul 2017 12:49:50 -0500
Subject: [PATCH 1/2] net: phy: at803x: Fix RGMII RX and TX clock delays
 setup
In-Reply-To: <33ed5f4f-9939-dc00-b973-db39c16f2393@sigmadesigns.com>
References: <b332dc3e-4478-e34b-2b3f-226aad8a11d4@sigmadesigns.com>
 <33ed5f4f-9939-dc00-b973-db39c16f2393@sigmadesigns.com>
Message-ID: <d0b7027d-1306-a114-00c0-8e3cb01d4d0e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2017 10:31 AM, Marc Gonzalez wrote:
> The current code supports enabling RGMII RX and TX clock delays.
> The unstated assumption is that these settings are disabled by
> default at reset, which is not the case.
> 
> RX clock delay is enabled at reset. And TX clock delay "survives"
> across SW resets. Thus, if the bootloader enables TX clock delay,
> it will remain enabled at reset in Linux.
> 
> Provide disable functions to configure the RGMII clock delays
> exactly as specified in the fwspec.

I only use SGMII mode, and I tested and can confirm that this patch does 
not break SGMII, so:

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
