From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 13 Oct 2015 08:51:52 +0530
Subject: [PATCH 1/3] ARM: dts: exynos5422-odroidxu3: use cd-gpio method to
 detect sd-card
In-Reply-To: <561C6713.1070508@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <561B3739.4040701@samsung.com> <561B3A83.6090607@samsung.com>
 <1111856990.2419183.1444661252893.JavaMail.yahoo@mail.yahoo.com>
 <561C4C88.2040004@samsung.com> <561C6713.1070508@samsung.com>
Message-ID: <CANAwSgQn8gb5DkLvULC26vhe+gwSD2mn1Ba7y2hPGo4ibZcLgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaehoon Chung,

On 13 October 2015 at 07:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Anand.
>
>
> On 10/13/2015 09:12 AM, Krzysztof Kozlowski wrote:
>> On 12.10.2015 23:47, Anand Moon wrote:
>>>>
>>>> Anand,
>>>>
>>>> You essentially reverted here af6ad88acbd6 ("ARM: dts: Mux XMMCnDATA[0]
>>>> pad correctly for Exynos5420 boards"). Why? There is no explanation in
>>>> the commit message about this.
>>>
>>> I don't remember to send the patch relevant to this. Hmm...
>>> Well, Is this patch really signed-off by me?
>>>
>>> Best Regards,
>>>
>>> Jaehoon Chung
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>>>
>>>
>>>
>>> Some how I don't receive these mail on my email id.
>>>
>>> I have picked up these changes from tizen repository for OdroidXU3.
>>> I have tested with this changes to detect UHS-I micro cd cards.
>>> That's the reason for this email.
>
> It seems to make manually, right?
> I have checked the tizen repository.
>
> The below is
>
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -335,7 +335,9 @@
>         samsung,dw-mshc-sdr-timing = <0 4>;
>         samsung,dw-mshc-ddr-timing = <0 2>;
>         pinctrl-names = "default";
> -       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> +       cd-gpios = <&gpc2 2 0>;
> +       cd-inverted;
> +       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4>;
>         bus-width = <4>;
>         cap-sd-highspeed;
>  };
>
>
>
> Yours
>
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -352,8 +352,10 @@
>         samsung,dw-mshc-ciu-div = <3>;
>         samsung,dw-mshc-sdr-timing = <0 4>;
>         samsung,dw-mshc-ddr-timing = <0 2>;
> +       cd-gpios = <&gpc2 2 GPIO_ACTIVE_HIGH>;
> +       cd-inverted;
>         pinctrl-names = "default";
> -       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> +       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>
> Did you know what differ? :)
>

My mistake, I will drop the changes. Sorry for the whole mess.

-Anand Moon

> Best Regards,
> Jaehoon Chung
>
>>
>> ... and you applied it blindly without looking at actual existing
>> contents and at previous commits.
>>
>> That is not how patches from different repositories should be cherry picked.
>>
>> Best regards,
>> Krzysztof
>>
>>
>
