From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 18:40:58 +0000
Subject: [PATCH v2] arm64: use local label prefixes for __reg_num symbols
In-Reply-To: <1455526309-18519-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455526309-18519-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160216184058.GF19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:51:49AM +0100, Ard Biesheuvel wrote:
> The __reg_num_xNN symbols that are used to implement the msr_s and
> mrs_s macros are recorded in the ELF metadata of each object file.
> This does not affect the size of the final binary, but it does clutter
> the output of tools like readelf, i.e.,
> 
>   $ readelf -a vmlinux |grep -c __reg_num_x
>   50976
> 
> So let's use symbols with the .L prefix, these are strictly local,
> and don't end up in the object files.
> 
>   $ readelf -a vmlinux |grep -c __reg_num_x
>   0
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
