From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 24 Oct 2014 16:23:28 +0100
Subject: [PATCH 1/6] arm64/mm: add explicit struct_mm argument to
 __create_mapping()
In-Reply-To: <1414154384-15385-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1414154384-15385-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414154384-15385-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141024152324.GB22807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 02:39:39PM +0200, Ard Biesheuvel wrote:
> Currently, swapper_pg_dir and idmap_pg_dir share the init_mm mm_struct
> instance. To allow the introduction of other pg_dir instances, for instance,
> for UEFI's mapping of Runtime Services, make the struct_mm instance an
> explicit argument that gets passed down to the pmd and pte instantiation
> functions. Note that the consumers (pmd_populate/pgd_populate) of the
> mm_struct argument don't actually inspect it, but let's fix it for
> correctness' sake.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Steve Capper <steve.capper@linaro.org>
