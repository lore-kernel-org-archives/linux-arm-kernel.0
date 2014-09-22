From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Sep 2014 11:09:12 +0100
Subject: [PATCH v3] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1411167781-18571-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1411167781-18571-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140922100912.GG30085@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 12:03:01AM +0100, Ard Biesheuvel wrote:
> From: Yi Li <yi.li@linaro.org>
> 
> SMBIOS is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the like.
> 
> This has been tested by dmidecode and lshw tools.
> 
> This patch adds the call to dmi_scan_machine() to arm64_enter_virtual_mode(),
> as that is the point where the EFI Configuration Tables are registered as
> being available. It needs to be in an early_initcall anyway as dmi_id_init(),
> which is an arch_initcall itself, depends on dmi_scan_machine() having been
> called already.
> 
> Signed-off-by: Yi Li <yi.li@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Merged (until the next revert ;)). Thanks.

-- 
Catalin
