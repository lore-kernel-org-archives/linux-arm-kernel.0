From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Oct 2017 18:11:17 +0100
Subject: [PATCH v3 20/28] arm64/sve: Add prctl controls for userspace
 vector length management
In-Reply-To: <1507660725-7986-21-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-21-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171012171117.fn4rx4wxps6tcve5@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:37PM +0100, Dave P Martin wrote:
> This patch adds two arm64-specific prctls, to permit userspace to
> control its vector length:
> 
>  * PR_SVE_SET_VL: set the thread's SVE vector length and vector
>    length inheritance mode.
> 
>  * PR_SVE_GET_VL: get the same information.
> 
> Although these calls shadow instruction set features in the SVE
> architecture, these prctls provide additional control: the vector
> length inheritance mode is Linux-specific and nothing to do with
> the architecture, and the architecture does not permit EL0 to set
> its own vector length directly.  Both can be used in portable tools
> without requiring the use of SVE instructions.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
