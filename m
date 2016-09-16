From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 13:42:41 +0200
Subject: [PATCH v2 00/10] pinctrl: exynos/samsung: Add header with values
 used for configuration
In-Reply-To: <CACRpkdZuRym=SuAiBA_UsNmKd7N5n9g=z=ZxwcEk7J0BcXDsFw@mail.gmail.com>
References: <1472714638-15676-1-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdZuRym=SuAiBA_UsNmKd7N5n9g=z=ZxwcEk7J0BcXDsFw@mail.gmail.com>
 <CGME20160916114244eucas1p2f585ef754b0523022a04a5646a06da36@eucas1p2.samsung.com>
Message-ID: <3a004c08-26b3-d5cd-dbc3-bc0f47814570@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2016 10:20 PM, Linus Walleij wrote:
> I have one comment though, if you're anyway making changes to all
> the DTS files:
> 
> On Thu, Sep 1, 2016 at 9:23 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> 
>> -               samsung,pin-function = <2>;
>> -               samsung,pin-pud = <0>;
>> -               samsung,pin-drv = <0>;
>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> 
> Nowadays we have standard bindings for this, see
> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> 
> Section "Generic pin multiplexing node content".
> 
> By patching the driver and bindings to accept also the standard
> bindings with just function and pins and also adding support
> for standard pin configurations like bias-disable
> bias-pull-up with the old samsung,* bindings as a fallback
> etc you can actually modernize the whole binding and
> DTS looks to something simpler.
> 
> You will find that this is how newer platforms do it.
> 
> But it is admittedly a bigger project.

Indeed it would be nice to support generic bindings. Almost certainly I
won't have time for implementing this but it looks like a good task for
newcomers.

Best regards,
Krzysztof
