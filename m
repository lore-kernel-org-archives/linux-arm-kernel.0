From: carlo@caione.org (Carlo Caione)
Date: Tue, 6 Jun 2017 08:20:32 +0200
Subject: [PATCH] ARM64: dts: meson-gx: Fix sensors reporting from SCP
In-Reply-To: <m2mv9mdrt3.fsf@baylibre.com>
References: <20170605200350.1113-1-carlo@caione.org>
 <m2mv9mdrt3.fsf@baylibre.com>
Message-ID: <CAOQ7t2Z1rh-K4dgmGKC7YPSQcfQ+RDrS0Asek0L9cUPT9Nmc1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 11:54 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Carlo Caione <carlo@caione.org> writes:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Switch to use the new compatible for the SCPI sensors so that the
>> sensor readings are reported using the correct scale.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 436b875..3128fa5 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -200,7 +200,7 @@
>>               };
>>
>>               scpi_sensors: sensors {
>> -                     compatible = "arm,scpi-sensors";
>> +                     compatible = "amlogic,meson-gxbb-scpi-sensors";
>
> Shouldn't this be:
>
>                         compatible = "amlogic,meson-gxbb-scpi-sensors", "arm,scpi-sensors";
>
> For a safe fallback on kernels without the new compatible?

Yeah, it should.

-- 
Carlo Caione
