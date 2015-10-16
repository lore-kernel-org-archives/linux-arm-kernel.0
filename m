From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Oct 2015 09:56:30 -0700
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <5294153.vxTnuIq2gr@wuerfel>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
 <5294153.vxTnuIq2gr@wuerfel>
Message-ID: <56212C3E.8010603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 02:05 PM, Arnd Bergmann wrote:
>
>  This also seemed like the right place
> to add a bugfix that I had in my queue:
>
> commit 73ebb85444b0472d90bb70a1a9e6b5df3f92c14c
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Oct 13 17:05:39 2015 +0200
>
>     soc: qcom/smem: add HWSPINLOCK dependency
>     
>     This fixes a build error when smem is enabled without hwspinlock:
>     
>     drivers/built-in.o: In function `qcom_smem_alloc':
>     rockchip-efuse.c:(.text+0x7a3e4): undefined reference to `__hwspin_lock_timeout'
>     rockchip-efuse.c:(.text+0x7a568): undefined reference to `__hwspin_unlock'
>     drivers/built-in.o: In function `qcom_smem_remove':
>     rockchip-efuse.c:(.text+0x7a5cc): undefined reference to `hwspin_lock_free'
>     drivers/built-in.o: In function `qcom_smem_probe':
>     rockchip-efuse.c:(.text+0x7a960): undefined reference to `hwspin_lock_request_specific'
>     rockchip-efuse.c:(.text+0x7a988): undefined reference to `of_hwspin_lock_get_id'
>     drivers/built-in.o: In function `qcom_smem_get':
>     rockchip-efuse.c:(.text+0x7aa24): undefined reference to `__hwspin_lock_timeout'
>     rockchip-efuse.c:(.text+0x7aafc): undefined reference to `__hwspin_unlock'
>     

Can you share your .config? It looks like there are stubs for these, so
I'm lost how we got undefined references.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
