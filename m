From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 16:51:19 +0000
Subject: [PATCH v2] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <1297724147-6320-1-git-send-email-ccross@android.com>
References: <AANLkTik_Jey_PtRmr530FVckA6RXHESeX+CyoJC=ZTkR@mail.gmail.com>
	<1297724147-6320-1-git-send-email-ccross@android.com>
Message-ID: <1297788679.28844.4.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-14 at 22:55 +0000, Colin Cross wrote:
> vfp_pm_suspend should save the VFP state any time there is
> a last_VFP_context.  If it only saves when the VFP is enabled,
> the state can get lost when, on a UP system:
>    Thread 1 uses the VFP
>    Context switch occurs to thread 2, VFP is disabled but the
>       VFP context is not saved to allow lazy save and restore
>    Thread 2 initiates suspend
>    vfp_pm_suspend is called with the VFP disabled, but the
>       context has not been saved.
> 
> Modify vfp_pm_suspend to save the VFP context whenever
> last_VFP_context is set.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
