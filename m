From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 16:13:31 +0000
Subject: [PATCH v4] iommu/arm-smmu: Support for Extended Stream ID (16 bit)
In-Reply-To: <20170119143653.7576-1-aleksey.makarov@linaro.org>
References: <20170119143653.7576-1-aleksey.makarov@linaro.org>
Message-ID: <20170119161331.GG31594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 05:36:36PM +0300, Aleksey Makarov wrote:
> It is the time we have the real 16-bit Stream ID user, which is the
> ThunderX. Its IO topology uses 1:1 map for Requester ID to Stream ID
> translation for each root complex which allows to get full 16-bit
> Stream ID.  Firmware assigns bus IDs that are greater than 128 (0x80)
> to some buses under PEM (external PCIe interface).  Eventually SMMU
> drops devices on that buses because their Stream ID is out of range:
> 
>   pci 0006:90:00.0: stream ID 0x9000 out of range for SMMU (0x7fff)
> 
> To fix above issue enable the Extended Stream ID optional feature
> when available.
> 
> Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Tested-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
> ---
> v4:
> change the commit message:
> - explain the reason why the warning happens (Tomasz Nowicki)
> - add 'Reviewed-by' and 'Tested-by' from Tomasz Nowicki

Thanks, I'll queue this for 4.11.

Will
