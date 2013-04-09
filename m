From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:57:29 +0200
Subject: [PATCH 5/8] dmaengine: ste_dma40: Ensure src and dst registers
 are configured correctly
In-Reply-To: <1365532783-27425-5-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-5-git-send-email-lee.jones@linaro.org>
Message-ID: <201304092057.29684.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> Confusingly d40_log_cfg() is used to set up the logical channel
> configuration registers, but d40_phy_cfg() is used to configure
> physical and logical registers, so it should be called in both
> cases. It is the function call's final attribute which determines
> whether it's a physical or logical channel, not whether the
> function is called or not.

So how did it ever work? Your description sounds like it was
broken all along, but I would assume that someone tested the code.

	Arnd
