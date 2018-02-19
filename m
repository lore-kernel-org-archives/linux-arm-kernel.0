From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Feb 2018 17:02:30 +0000
Subject: [PATCH] arm64: cpufeature: Fix CTR_EL0 field definitions
In-Reply-To: <1519051304-25141-1-git-send-email-will.deacon@arm.com>
References: <1519051304-25141-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180219170229.akb4pupomzpbhxjr@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 02:41:44PM +0000, Will Deacon wrote:
> Our field definitions for CTR_EL0 suffer from a number of problems:
> 
>   - The IDC and DIC fields are missing, which causes us to enable CTR
>     trapping on CPUs with either of these returning non-zero values.
> 
>   - The ERG is FTR_LOWER_SAFE, whereas it should be treated like CWG as
>     FTR_HIGHER_SAFE so that applications can use it to avoid false sharing.
> 
>   - [nit] A RES1 field is described as "RAO"
> 
> This patch updates the CTR_EL0 field definitions to fix these issues.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for -rc3.

-- 
Catalin
