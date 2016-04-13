From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 14:58:11 -0700
Subject: [PATCH v2 1/5] ARM: STi: stih407-family: Add nodes for Mailbox
In-Reply-To: <1458744223-12164-2-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
 <1458744223-12164-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMjQwi_JZ_SKhKZXhrrm2EiCDgqhJ6MQvQCMQsO9-Dhuzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 23, 2016 at 7:43 AM, Lee Jones <lee.jones@linaro.org> wrote:
> This patch supplies the Mailbox Controller nodes.  In order to
> request channels, these nodes will be referenced by Mailbox
> Client nodes.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 81f8121..e6e34b4 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -694,5 +694,38 @@
>                         clocks          = <&clk_sysin>;
>                         status          = "okay";
>                 };
> +
> +               mailbox0: mailbox at 0  {

This isn't the right unit-id here. It should be @8f000000. Same for
the other two.


-Olof
