From: agross@codeaurora.org (Andy Gross)
Date: Wed, 25 Nov 2015 15:06:40 -0600
Subject: [PATCH] ARM: qcom: select ARM_CPU_SUSPEND for power management
In-Reply-To: <5497046.7sx8fEMiNf@wuerfel>
References: <5497046.7sx8fEMiNf@wuerfel>
Message-ID: <20151125210640.GA5643@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 11:13:09PM +0100, Arnd Bergmann wrote:
> The qcom spm driver uses cpu_resume_arm(), which is not included
> in the kernel in all configurations:
> 
> drivers/built-in.o: In function `qcom_cpu_spc':
> :(.text+0xbc022): undefined reference to `cpu_suspend'
> drivers/built-in.o: In function `qcom_cpuidle_init':
> :(.init.text+0x610c): undefined reference to `cpu_resume_arm'
> 
> This adds a 'select' Kconfig statement to ensure it's always
> enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This has been broken for a while but not even shown up in many thousands of
> randconfig builds until today. Please queue it up for 4.5 unless you think
> it should really go into 4.4 as well.

Thanks Arnd.  I'll add this to my list for the pull request.
