From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 17:16:39 +0100
Subject: [PATCH v3 12/28] arm64/sve: Support vector length resetting for
 new processes
In-Reply-To: <1507660725-7986-13-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-13-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011161638.wdj6mka3pm24lebg@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:29PM +0100, Dave P Martin wrote:
> It's desirable to be able to reset the vector length to some sane
> default for new processes, since the new binary and its libraries
> processes may or may not be SVE-aware.
> 
> This patch tracks the desired post-exec vector length (if any) in a
> new thread member sve_vl_onexec, and adds a new thread flag
> TIF_SVE_VL_INHERIT to control whether to inherit or reset the
> vector length.  Currently these are inactive.  Subsequent patches
> will provide the capability to configure them.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
