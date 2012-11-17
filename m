From: csd_b@daudt.org (Christian Daudt)
Date: Sat, 17 Nov 2012 08:07:20 -0800
Subject: [PATCH V3] Add support for generic BCM SoC chipsets
In-Reply-To: <50A70E1E.9070907@wwwdotorg.org>
References: <1352843517-31328-1-git-send-email-csd@broadcom.com>
 <50A70E1E.9070907@wwwdotorg.org>
Message-ID: <CAGFynZ-Ana17ngAvns=WgXErrqMcgD=JxrogqKZGAYpzsejE9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 8:10 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/13/2012 02:51 PM, Christian Daudt wrote:
>> In order to start upstreaming Broadcom SoC support, create
>> a starting hierarchy, arch and dts files.
>> The first support SoC family that is planned is the
>> BCM281XX (BCM11130/11140/11351/28145/28155) family of dual A9 mobile
>> SoC cores.
>> This code is just the skeleton code for get the machine upstreamed. It
>> has been made MULTIPLATFORM compatible.
>
> Sorry for the slow review...
>
no worries.

>> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt b/Documentation/devicetree/bindings/arm/bcm/bcm281xx.txt
>
>> +Required root node property:
>> +
>> +compatible = "bcm,bcm281xx";
>
> Hmm. I still tend to think we should list the specific SoC rather than
> the family here, but I guess if you're sure there won't be any SW
> compatibility between the different SoCs in the series, this is fine.
>

right now I expect to be able to use the family thoughout, so I'll stick to it.

>> diff --git a/arch/arm/boot/dts/bcm281xx.dtsi b/arch/arm/boot/dts/bcm281xx.dtsi
>
>> +     uart at 3e000000 {
>> +             compatible = "snps,dw-apb-uart", "bcm,bcm281xx-sw-apb-uart";
>
> The most specific value should be first, so swap those two entries.
>
ok. done

>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>
>> +     help
>> +       This enables support for system based on Broadcom SoCs.
>> +       It currently supports the 'BCM281XX' family, which includes
>> +       BCM11130, BCM1140, BCM11351, BCM28145 and
>
> Should that be 11140 rather than 1140?
yes. that's a typo. corrected.

>
> Aside from that,
> Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

thanks for reviewing it !

 csd
