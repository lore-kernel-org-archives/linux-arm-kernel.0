From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Aug 2016 17:20:48 +0100
Subject: [PATCH v2 3/9] arm64: kernel: use ordinary return/argument
 register for el2_setup()
In-Reply-To: <1472049366-10922-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160824162047.GB30036@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 04:36:00PM +0200, Ard Biesheuvel wrote:
> The function el2_setup() passes its return value in register w20, and
> in the two cases where the caller actually cares about this return value,
> it is passed into set_cpu_boot_mode_flag() [almost] directly, which
> expects its input in w20 as well.
> 
> So there is no reason to use a 'special' callee saved register here, but
> we can simply follow the PCS for return value and first argument,
> respectively.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Make sense to me. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
