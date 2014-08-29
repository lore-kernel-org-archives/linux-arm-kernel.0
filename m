From: bp@alien8.de (Borislav Petkov)
Date: Fri, 29 Aug 2014 18:02:04 +0200
Subject: [PATCHv10 1/2] edac: altera: Add Altera SDRAM EDAC support.
In-Reply-To: <1407770293-27190-2-git-send-email-tthayer@opensource.altera.com>
References: <1407770293-27190-1-git-send-email-tthayer@opensource.altera.com>
 <1407770293-27190-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20140829160204.GA8835@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 10:18:12AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch adds support for the CycloneV and ArriaV SDRAM controllers.
> Correction and reporting of SBEs, Panic on DBEs.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Use the SDRAM controller registers to calculate memory size
>     instead of the Device Tree. Update To & Cc list. Add maintainer
>     information.
> 
> v3: EDAC driver cleanup based on comments from Mailing list.
> 
> v4: Panic on DBE. Add macro around inject-error reads to prevent
>     them from being optimized out. Remove of_match_ptr since this
>     will always use Device Tree.
> 
> v5: Addition of printk to trigger function to ensure read vars
>     are not optimized out.
> 
> v6: Changes to split out shared SDRAM controller reg (offset 0x00)
>     as a syscon device and allocate ECC specific SDRAM registers
>     to EDAC.
> 
> v7: No changes. Bump for consistency.
> 
> v8: Alphabetize headers.
> 
> v9: Changes to support a MFD SDRAM controller with nested EDAC.
> 
> v10: Revert to version 5 (syscon) and fix errors found in v5.

EDAC bits look ok to me,

Acked-by: Borislav Petkov <bp@suse.de>

Dinh, please convert that version information above to a nice commit
message and add it when applying as it is very useful for future
reference.

Thanks.

-- 
Regards/Gruss,
    Boris.
--
