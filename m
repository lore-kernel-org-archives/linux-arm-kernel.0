From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 9 Oct 2016 16:04:11 +0900
Subject: [PATCH v3 00/17] pinctrl: exynos/samsung: Add header with values
 used for configuration
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <CA+Ln22Eotn=dLyA8KYT_6Fnwvp1sTSxzP8DepAFB2P8EUMME6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

2016-09-04 20:04 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>
> Hi,
>
> Changes since v2
> ================
> 1. Combine separate patchsets into one. Previously I sent separately the fixes
>    and changes for S3C platforms.
> 2. Fix issues pointed during review.
> 3. Add review tags.
>
> Changes since v1
> ================
> 1. Follow Arnd's suggestion about moving the macros to common place.
> 2. Subjects: replace "GPIO" with "pinctrl".
> 3. There were some major changes here so I did not add Javier's
>    reviewed-by and tested-by tags.
>
> Merging
> =======
> Patches #1 and #2 should probably go through pinctrl tree. In that case I would
> appreciate a stable branch/tag so DTS could base on top of it.
>
> Goal
> ====
> Increase readability:
>         uart0_data: uart0-data {
>                 samsung,pins = "gpa0-0", "gpa0-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;

I like the idea, thanks for cleaning this up. However I'd like to
bikeshed the prefix a bit. Since the properties are already prefixed
by "samsung,", I think it would make much more sense to also prefix
the generic values with "SAMSUNG_". Of course for soc/family-specific
values, the soc/family name prefix sounds right.

Similarly for rest of the value names, such as SAMSUNG_PIN_PUD instead
of SAMSUNG_PIN_PULL, which obviously sounds more like correct English,
however hurts the consistency and could confuse the people writing new
dts files.

Best regards,
Tomasz
