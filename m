From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 18:47:50 +0100
Subject: [PATCH] arm64: errata: use KBUILD_CFLAGS_MODULE for erratum
 #843419
In-Reply-To: <1444325555-32108-1-git-send-email-will.deacon@arm.com>
References: <1444325555-32108-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151008174750.GR17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 06:32:35PM +0100, Will Deacon wrote:
> Commit df057cc7b4fa ("arm64: errata: add module build workaround for
> erratum #843419") sets CFLAGS_MODULE to ensure that the large memory
> model is used by the compiler when building kernel modules.
> 
> However, CFLAGS_MODULE is an environment variable and intended to be
> overridden on the command line, which appears to be the case with the
> Ubuntu kernel packaging system, so use KBUILD_CFLAGS_MODULE instead.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: Dann Frazier <dann.frazier@canonical.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Just you case you forgot, I think you also need:

Fixes: df057cc7b4fa ("arm64: errata: add module build workaround for erratum #843419")
Cc: <stable@vger.kernel.org>

-- 
Catalin
