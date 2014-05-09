From: menon.nishanth@gmail.com (menon.nishanth at gmail.com)
Date: Fri, 9 May 2014 12:02:12 -0500
Subject: [PATCH 1/3] arm64: Enable OPP
In-Reply-To: <1399653631-4938-1-git-send-email-broonie@kernel.org>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
Message-ID: <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 9, 2014 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Some of the generic drivers used on ARM class systems use OPP so allow it
> to be selected in Kconfig. No code is required for this, it is not clear
> to me why there is config for this option.
If you mean why we have ARCH_HAS_OPP,
http://lists-archives.com/linux-kernel/27401148-pm-hide-opp-configuration-when-socs-do-not-provide-an-implementation.html

>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8ccdd2646ae3..8256d6d09d33 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@ config ARM64
>         def_bool y
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select ARCH_HAS_OPP
>         select ARCH_HAS_SG_CHAIN
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_WANT_OPTIONAL_GPIOLIB
> --
> 2.0.0.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
