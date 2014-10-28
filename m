From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 28 Oct 2014 13:34:03 +0900
Subject: [PATCH v2 07/10] ARM: dts: tegra: Use standard power-off property
 in tps65911 for tegra30 apalis
In-Reply-To: <20141027164214.GF14253@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-7-git-send-email-romain.perier@gmail.com>
 <20141027164214.GF14253@saruman>
Message-ID: <CAAVeFuL2MvbC9U-8fM=QPhkvnaMRZ8kep9WpD8hhU4m4cGWjLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 1:42 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Oct 27, 2014 at 04:26:52PM +0000, Romain Perier wrote:
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> ---
>>  arch/arm/boot/dts/tegra30-apalis.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
>> index a5446cb..ced4436 100644
>> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
>> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
>> @@ -412,7 +412,7 @@
>>                       #interrupt-cells = <2>;
>>                       interrupt-controller;
>>
>> -                     ti,system-power-controller;
>> +                     system-power-controller;
>
> this board is broken until this patch is applied.

It should not. Supporting a new property in the tps65911 is fine, but
the old property must keep being supported to preserve DT
compatibility. If a change removing support for
"ti,system-power-controller" has landed in -next, then it should be
removed.
