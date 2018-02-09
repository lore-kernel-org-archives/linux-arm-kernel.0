From: julien.grall@arm.com (Julien Grall)
Date: Fri, 9 Feb 2018 12:31:25 +0000
Subject: [PATCH v3 08/41] KVM: arm/arm64: Introduce vcpu_el1_is_32bit
In-Reply-To: <20180112120747.27999-9-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-9-christoffer.dall@linaro.org>
Message-ID: <eefa89b7-74d1-7ced-cf11-cdba96341755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 01/12/2018 12:07 PM, Christoffer Dall wrote:
> We have numerous checks around that checks if the HCR_EL2 has the RW bit
> set to figure out if we're running an AArch64 or AArch32 VM.  In some
> cases, directly checking the RW bit (given its unintuitive name), is a
> bit confusing, and that's not going to improve as we move logic around
> for the following patches that optimize KVM on AArch64 hosts with VHE.
> 
> Therefore, introduce a helper, vcpu_el1_is_32bit, and replace existing
> direct checks of HCR_EL2.RW with the helper.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
