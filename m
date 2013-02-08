From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Feb 2013 16:23:41 +0530
Subject: [PATCH 2/3] ARM:dts:SPEAr1310:Correct the clcd pin group name
In-Reply-To: <4854ebf7198ff341d699372cf569210a6f0b363b.1360317993.git.vijay.kumar@st.com>
References: <cover.1360317993.git.vijay.kumar@st.com>
 <4854ebf7198ff341d699372cf569210a6f0b363b.1360317993.git.vijay.kumar@st.com>
Message-ID: <CAKohpo=rvp8b0QhjyXiKZ9vezTZKZG6moc85JAFi3NES0+WvDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove "the" from subject.

On 8 February 2013 16:16, Vijay Kumar Mishra <vijay.kumar@st.com> wrote:
> This patch is to correct clcd pin group name "clcd_high_res" to
> "clcd_high_res_grp" to avoid kernel boot hang as with following error message.
>
> spear1310-pinmux e0700000.pinmux: invalid group "clcd_high_res" for function
> "clcd".

Write it as:

Incorrect pin group name "clcd_high_res" is passed from DT, which causes boot
failure. Fix it by replacing it with "clcd_high_res_grp".

> ---
>  arch/arm/boot/dts/spear1310-evb.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
> index b56a801..6fd4c36 100644
> --- a/arch/arm/boot/dts/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/spear1310-evb.dts
> @@ -47,7 +47,7 @@
>                                         st,function = "arm_gpio";
>                                 };
>                                 clcd {
> -                                       st,pins = "clcd_grp" , "clcd_high_res";
> +                                       st,pins = "clcd_grp", "clcd_high_res_grp";
>                                         st,function = "clcd";
>                                 };
>                                 eth {
