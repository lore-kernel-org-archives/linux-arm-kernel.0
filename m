From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 12 Feb 2018 17:52:24 -0600
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
In-Reply-To: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 05:45 PM, Florian Fainelli wrote:
> +config ARM64_L1_CACHE_SHIFT
> +	int
> +	default 7 if ARM64_L1_CACHE_SHIFT_7
> +	default 6

Shouldn't this be the other way around?  Everyone is used to 7 now, so 
you're changing the default back to 6.  I would think that it should be 
7 by default, and platforms like Brahma-B53 should force it to 6.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
