From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 15:04:41 +0000
Subject: [PATCH] arm64: use local label prefixes for __reg_num symbols
In-Reply-To: <1453917687-2494-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453917687-2494-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160128150441.GF775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 07:01:27PM +0100, Ard Biesheuvel wrote:
> The __reg_num_xNN symbols that are used to implement the msr_s and
> mrs_s macros are recorded in the ELF metadata of each object file.
> This is not a problem in terms of code size, but it does clobber
> the output of tools like readelf, i.e.,
> 
>   $ readelf -a vmlinux |grep __reg_num_x | wc -l
>   50976
> 
> So let's use symbols with the .L prefix, these are strictly local,
> and don't end up in the object files.
> 
>   $ readelf -a vmlinux |grep __reg_num_x | wc -l
>   0
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/sysreg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Looks harmless enough:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
