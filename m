From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 26 Jul 2013 15:51:13 -0700
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <51F2F37B.8030306@wwwdotorg.org>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
 <51F2F37B.8030306@wwwdotorg.org>
Message-ID: <CAPdLdqmU0aw5h_KYcD-E=isC9U3mZF6fzr_GVdjUUAW4_PUD5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 July 2013 15:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
> (CC'ing the DT bindings maintainers hence quoting the binding in full)
>
> On 07/26/2013 02:25 PM, Markus Mayer wrote:
>
> Some kind of patch description is always useful.

I will add something along the lines of "GPIO device tree bindings for
the Broadcom bcm281xx family of chips."

>>  .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   41 ++++++++++++++++++++
>>  arch/arm/boot/dts/bcm11351.dtsi                    |   16 ++++++++
>
> It's more usual to put the DT binding doc change and driver change in
> one patch, then "make use of that" in a later separate patch which edits
> *.dts and *.dtsi.

Sure. I have no issue moving the gpio-bcm-kona.txt into the other
patch, together with the code.

>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
>
>> +Broadcom Kona Family GPIO
>> +-------------------------
>> +
>> +This GPIO driver is used in the following Broadcom SoCs:
>> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>> +
>> +The GPIO controller only supports edge, not level triggering.
>
> add "... of interrupts"? This might not be worth mentioning; it's
> clearly spelled out in the description of the interrupt cells below.

Added.

>> +Required properties:
>> +  - compatible: "brcm,kona-gpio"
>> +  - reg: Physical base address and length of the controller's registers.
>> +  - interrupts: The interrupt outputs from the controller.
>
> How many entries are required? I notice there's more than 1 in the
> example below.

You only "need" the ones you want to use, i.e. at least one. The board
supports up to 6. I can mention as much in the description.

[...]

>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>
>> +     gpio: gpio at 35003000 {
>> +             compatible = "brcm,kona-gpio";
>
> In order to enable any later chip-specific quirking requirements, that
> compatible property should both specify the IP block and the specific
> chip it's included in, so I'd expect to see something like:
>
>                 compatible = "brcm,brcm11351-gpio", "brcm,kona-gpio";

Added.

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
