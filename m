From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 24 Mar 2015 17:23:52 +0000
Subject: [PATCH 1/3] ARM: move cpu_resume() to .text section
In-Reply-To: <1427213430-28463-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1427213430-28463-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427213430-28463-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <55119DA8.1000707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/15 16:10, Ard Biesheuvel wrote:
> Move cpu_resume() to the .text section where it belongs. Change
> the adr reference to sleep_save_sp to an explicit PC relative
> reference so sleep_save_sp itself can remain in .data.
>
> This helps prevent linker failure on large kernels, as the code
> in the .data section may be too far away to be in range for normal
> b/bl instructions.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(Tested on Vexpress TC2 with CPUIdle enabled)
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
