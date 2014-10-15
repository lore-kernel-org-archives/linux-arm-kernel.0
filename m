From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Oct 2014 15:50:20 +0100
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <1413353496-4778-1-git-send-email-victor.kamensky@linaro.org>
References: <1413353496-4778-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20141015145019.GE22949@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 07:11:36AM +0100, Victor Kamensky wrote:
> The compat_elf_prpsinfo structure does not match the arch/arm struct
> elf_pspsinfo definition. As result NT_PRPSINFO note in core file
> created by arm64 kernel for aarch32 (compat) process has wrong size.
> So gdb cannot display command that caused process crash.
> 
> Fix is to change size of __compat_uid_t, __compat_gid_t so it would
> match size of similar fields in arch/arm case.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org

Applied, thanks (it will go in after -rc1).

-- 
Catalin
