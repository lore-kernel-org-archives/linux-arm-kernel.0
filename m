From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 16:57:50 +0000
Subject: [patch v11 08/23] ARM64 / ACPI: Introduce early_param "acpi=" to
 enable/disable ACPI
In-Reply-To: <1427205776-5060-9-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325165750.GF14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:41PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> This implements the following policy to decide whether ACPI should
> be used to boot the system:
> - acpi=off: ACPI will not be used to boot the system, even if there is
>   no alternative available (e.g., device tree is empty)
> - acpi=force: only ACPI will be used to boot the system; if that fails,
>   there will be no fallback to alternative methods (such as device tree)
> - otherwise, ACPI will be used as a fallback if the device tree turns out
>   to lack a platform description; the heuristic to decide this is whether
>   /chosen is the only node present at depth 1
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

But we should also merge Lorenzo's patch which gets read of the forced
param (on top of this series, I really think we should stop rebasing at
this point).

-- 
Catalin
