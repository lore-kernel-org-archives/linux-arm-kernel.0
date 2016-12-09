From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 09 Dec 2016 14:42:36 +0530
Subject: [RESEND-PATCH] ARM: EXYNOS: remove smp hook from machine
 descriptor
In-Reply-To: <20161208173349.GA8522@kozik-lap>
References: <1481166135-1588-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161208173359epcas2p4ee51a2589fba2bc67418d4e82661bea2@epcas2p4.samsung.com>
 <20161208173349.GA8522@kozik-lap>
Message-ID: <fbc36736-ce7c-3eed-2833-c2e45ea02ce5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Thursday 08 December 2016 11:03 PM, Krzysztof Kozlowski wrote:
> On Thu, Dec 08, 2016 at 08:32:15AM +0530, Pankaj Dubey wrote:
>> Use CPU_METHOD_OF_DECLARE() for smp_ops instead of using it
>> via machine descriptor.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>
>> Resending as I missed to include samsung mailing list.
>>
>>  arch/arm/boot/dts/exynos3250.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos4210.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos4212.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos4412.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos5250.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos5260.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos5410.dtsi      | 1 +
>>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 1 +
>>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 1 +
>>  arch/arm/boot/dts/exynos5440.dtsi      | 1 +
>>  arch/arm/mach-exynos/common.h          | 2 --
>>  arch/arm/mach-exynos/exynos.c          | 1 -
>>  arch/arm/mach-exynos/platsmp.c         | 2 ++
>>  13 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>> index ba17ee1..f28f669 100644
>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> @@ -53,6 +53,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index 7f3a18c..6dfd98d 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -35,6 +35,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 900 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
>> index 5389011..3e8982e 100644
>> --- a/arch/arm/boot/dts/exynos4212.dtsi
>> +++ b/arch/arm/boot/dts/exynos4212.dtsi
>> @@ -25,6 +25,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at A00 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index 40beede..faf2fb8 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -25,6 +25,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at A00 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index b6d7444..580897c 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -52,6 +52,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
>> index 5818718..1af6e76 100644
>> --- a/arch/arm/boot/dts/exynos5260.dtsi
>> +++ b/arch/arm/boot/dts/exynos5260.dtsi
>> @@ -32,6 +32,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
>> index 2b6adaf..b092cdc 100644
>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>> @@ -33,6 +33,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> index 5c052d7..a587704 100644
>> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> @@ -24,6 +24,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> index bf3c6f1..7fcdfd0 100644
>> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> @@ -23,6 +23,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu0: cpu at 100 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
>> index 2a2e570..0a958e8 100644
>> --- a/arch/arm/boot/dts/exynos5440.dtsi
>> +++ b/arch/arm/boot/dts/exynos5440.dtsi
>> @@ -50,6 +50,7 @@
>>  	cpus {
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> +		enable-method = "samsung,exynos-smp";
>>  
>>  		cpu at 0 {
>>  			device_type = "cpu";
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index fb12d11..051e1ab 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -143,8 +143,6 @@ static inline void exynos_pm_init(void) {}
>>  extern void exynos_cpu_resume(void);
>>  extern void exynos_cpu_resume_ns(void);
>>  
>> -extern const struct smp_operations exynos_smp_ops;
>> -
>>  extern void exynos_cpu_power_down(int cpu);
>>  extern void exynos_cpu_power_up(int cpu);
>>  extern int  exynos_cpu_power_state(int cpu);
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index fa08ef9..f0a766e 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -211,7 +211,6 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
>>  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>>  	.l2c_aux_val	= 0x3c400001,
>>  	.l2c_aux_mask	= 0xc20fffff,
>> -	.smp		= smp_ops(exynos_smp_ops),
>>  	.map_io		= exynos_init_io,
>>  	.init_early	= exynos_firmware_init,
>>  	.init_irq	= exynos_init_irq,
>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
>> index 94405c7..43eec10 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -474,3 +474,5 @@ const struct smp_operations exynos_smp_ops __initconst = {
>>  	.cpu_die		= exynos_cpu_die,
>>  #endif
>>  };
>> +
>> +CPU_METHOD_OF_DECLARE(exynos_smp, "samsung,exynos-smp", &exynos_smp_ops);
> 
> Three issues:
> 1. This has to be documented. Checkpatch did not complain about it?

No it didn't.

> 2. I think this breaks the ABI with existing DTBs because now the
>    enable-method of cpus becomes mandatory. But the
>    Documentation/devicetree/bindings/arm/cpus.txt is saying that:
>    "On ARM 32-bit systems this property is optional and can be one of"
> 

I am not very sure that this is an ABI break, as other platforms (e.g
hisilicon,hip01-smp) also adopted this as some later stage and they also
removed smp hook support from their machine files when they adopted to
this enable-method in DTS files.

If we want to keep older DTBs keep working with new Kernel image, then I
need to drop patch from mach-exynos and keep smp_ops hook in machine
descriptor as it is to keep supporting older DTBs. I can see some
platforms have adopted this way as well.

Surely I will add new bindings details in
Documentation/devicetree/bindings/arm/cpus.txt file. I am not sure why
checkpatch did not complain about this?

> 3. Please split DTS changes to separate patches. This is, by the way,
>    connected with #2 above: if there was no ABI break, then the DTS
>    could go to separate branch easily.
> 

Since I am not sure if this will considered as ABI break or not, I just
looked how this was handled in other platforms, I can see some platforms
have clubbed DTS change along with mach files, and some have done in
separate patch as well. So I will look for suggestion from you for this
how we can go for exynos platform?


Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
> 
> 
> 
