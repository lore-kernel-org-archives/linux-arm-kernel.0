From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 28 Mar 2016 21:12:08 +0800
Subject: [PATCH v14 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
In-Reply-To: <1456735610-22012-4-git-send-email-fu.wei@linaro.org>
References: <1456735610-22012-1-git-send-email-fu.wei@linaro.org>
 <1456735610-22012-4-git-send-email-fu.wei@linaro.org>
Message-ID: <CADyBb7shY-A-DTKEvNQS71SUtNmE6tkURfWDEb-_9eB-4htGWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim, Guenter:

Great thanks for reviewing and applying this patchset :-)
Now I can see almost all the patches of this patchset have been merged
into the master branch of mainline kernel.
But only this one is still out of any branch or repo. It seems that
it's applied on linux-watchdog for a while, then disappeared.


So any thing I can do for this patch? Do I need to resubmit it?
Maybe I miss it in some repo? Could you help me ?
Great thanks ! :-)

On 29 February 2016 at 16:46,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index 2874d92..0a8ca1d 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -84,6 +84,14 @@
>                         clock-names = "uartclk", "apb_pclk";
>                 };
>
> +               watchdog0: watchdog at e0bb0000 {
> +                       compatible = "arm,sbsa-gwdt";
> +                       reg = <0x0 0xe0bc0000 0 0x1000>,
> +                               <0x0 0xe0bb0000 0 0x1000>;
> +                       interrupts = <0 337 4>;
> +                       timeout-sec = <15>;
> +               };
> +
>                 spi0: ssp at e1020000 {
>                         status = "disabled";
>                         compatible = "arm,pl022", "arm,primecell";
> --
> 2.5.0
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
