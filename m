From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2018 11:10:23 +0100
Subject: [PATCH V2 0/3] Emulate MRS instructions by parsing ESR_ELx.ISS
In-Reply-To: <1537416381-13674-1-git-send-email-anshuman.khandual@arm.com>
References: <1537416381-13674-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20180921101022.GB166997@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 09:36:18AM +0530, Anshuman Khandual wrote:
> Armv8.4-A extension enables MRS instruction encodings inside ESR_ELx.ISS
> during exception class ESR_ELx_EC_SYS64 (0x18). This encoding can be used
> to emulate MRS instructions which can avoid fetch/decode from user space
> thus improving performance. The patch series here enables this new method
> of emulating MRS instruction. For this purpose we factorizes the existing
> emulate_mrs() function and while here, add new macro ESR_ELx_SYS64_ISS_RT.
> 
> Changes in V2:
> 
> - Replaced the argument 'dst' as 'rt' in second patch per Suzuki
> - Added review tags from Suzuki
> 
> Anshuman Khandual (3):
>   arm64/cpufeatures: Introduce ESR_ELx_SYS64_ISS_RT()
>   arm64/cpufeatures: Factorize emulate_mrs()
>   arm64/cpufeatures: Emulate MRS instructions by parsing ESR_ELx.ISS

Queued for 4.20. Thanks.

-- 
Catalin
