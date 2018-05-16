From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 16 May 2018 13:31:54 -0500
Subject: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
Message-ID: <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 01:23 PM, Sinan Kaya wrote:
> +		win_start = window->res->start - window->offset;

Can you guarantee that window->res->start is always >= window->offset?

> +		win_size = window->res->end - window->res->start + 1;

Use resource_size() instead.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
