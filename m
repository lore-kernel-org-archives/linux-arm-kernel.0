From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 10:15:52 -0600
Subject: [PATCH v3 1/3] ARM: dts: STi: Fix aliases property name for STi
 boards
In-Reply-To: <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
 <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CAL_JsqKBkfCsx4pyjUebwkV0q+S5LhwePWw59-7ibt77qdAGbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 2:49 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Update serial aliases from "ttyASN" to more common "serialN".
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
> be lowercase only. This allows to fix following dtc warnings:
>
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v3: _ none
> v2: _ use serialN instead of ttyasN aliases to not break ABI
>
>  arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
>  arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index de3c8bf129b5..2c4d6033b448 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih407-b2120", "st,stih407";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";

These hunks for bootargs are still wrong. You wouldn't boot with a
console if you only apply patch 1. These hunks should be squashed with
patch 2.

>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 0a59b7b0f4b2..5422850641e8 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih410-b2120", "st,stih410";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";
>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index feb8834478fa..ca347160e35d 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -15,7 +15,7 @@
>         compatible = "st,stih410-b2260", "st,stih410";
>
>         chosen {
> -               bootargs = "console=ttyAS1,115200 clk_ignore_unused";
> +               bootargs = "console=serial1,115200 clk_ignore_unused";
>                 stdout-path = &uart1;
>         };
>
> @@ -25,7 +25,7 @@
>         };
>
>         aliases {
> -               ttyAS1 = &uart1;
> +               serial1 = &uart1;
>                 ethernet0 = &ethernet0;
>         };
>
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index 39b4db2e3507..dbf7bb704a1a 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih418-b2199", "st,stih418";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=serial0,115200 clk_ignore_unused";
>                 stdout-path = &sbc_serial0;
>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               serial0 = &sbc_serial0;
>                 ethernet0 = &ethernet0;
>         };
>
> --
> 1.9.1
>
