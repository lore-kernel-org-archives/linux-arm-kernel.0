From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 14:56:54 -0700
Subject: [PATCH v2 2/5] ARM: STi: DT: STiH407: Enable Mailbox testing
 facility
In-Reply-To: <1458744223-12164-3-git-send-email-lee.jones@linaro.org>
References: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
 <1458744223-12164-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMiG3XduERW+-hZkny6OFsyKP0j7W9P7OQzp7RF9Fv7ggw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,



On Wed, Mar 23, 2016 at 7:43 AM, Lee Jones <lee.jones@linaro.org> wrote:
> This patch supplies a Client node to enable the Mailbox testing
> facility.  It will be used to send and receive messages from any
> given co-processor in order to test the STi Mailbox Controller
> driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index e6e34b4..9376c38 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -695,6 +695,12 @@
>                         status          = "okay";
>                 };
>
> +               mailbox_test {
> +                       compatible = "mailbox_test";
> +                       mboxes = <&mailbox2 1 31>, <&mailbox0 1 31>;
> +                       mbox-names = "tx", "rx";
> +               };

As far as I understand, this doesn't describe something in your
system, and just configures the test driver to run a test. Is that
correct?



-Olof
