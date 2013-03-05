From: csd@broadcom.com (Christian Daudt)
Date: Tue, 5 Mar 2013 14:56:12 -0800
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <51363770.5060201@wwwdotorg.org>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
 <51363770.5060201@wwwdotorg.org>
Message-ID: <5136780C.7030801@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-03-05 10:20 AM, Stephen Warren wrote:
> On 03/04/2013 07:47 PM, Christian Daudt wrote:
>> - Adds a module to provide calls into secure monitor mode
>> - Uses this module to make secure monitor calls to enable L2 cache.
>> diff --git a/Documentation/devicetree/bindings/misc/smc.txt b/Documentation/devicetree/bindings/misc/smc.txt
>> +Example:
>> +	smc at 0x3404c000 {
>> +		compatible = "bcm,kona-smc";
> Both here in this example, and ...
>
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> +	smc at 0x3404c000 {
>> +		compatible = "bcm,kona-smc";
> Here in the actual .dts file, you should include the specific ID of the
> SoC too, so that if there are Soc-specific bugs, the compatible property
> that's required to determine this is present from the start. In other words,
>
> compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
>
> (which SoC ID you use in the example is arbitrary, but it may as well
> match the .dts file you're editing in the patch).
>

ok. done.

  thanks,
    csd
