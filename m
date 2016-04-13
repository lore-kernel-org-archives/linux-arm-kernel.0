From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 15:04:13 -0700
Subject: [PATCH v5 6/7] ARM: STiH407: Add nodes for RemoteProc
In-Reply-To: <1452602781-22424-7-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
 <1452602781-22424-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMj1zAgr+urvJHUu9=-P5RR5d9Ko6bUpXKTUcwkXMeYydg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 12, 2016 at 4:46 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 40 +++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 1e4e01925..15c20b6 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -650,5 +650,45 @@
>                         mbox-name       = "st231_audio_video";
>                         status          = "okay";
>                 };
> +
> +               st231_gp0: st231-gp0 at 40000000 {

These node names seem odd. Should probably be more generic
"remoteproc at 40000000".

> +                       compatible      = "st,st231-rproc";
> +                       reg             = <0x40000000 0x01000000>;

This isn't what the binding says, it uses a memory region instead.



-Olof
