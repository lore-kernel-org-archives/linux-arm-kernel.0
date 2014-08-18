From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Aug 2014 13:27:48 -0500
Subject: [RESEND PATCH 1/2] ARM: dts: Improve Peach Pit and Pi power scheme
In-Reply-To: <CAD=FV=UbckfwGucuPjEtHixVgF5K2fD5N3EPS2BH96DRDACuqw@mail.gmail.com>
References: <1407757091-18730-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=UbckfwGucuPjEtHixVgF5K2fD5N3EPS2BH96DRDACuqw@mail.gmail.com>
Message-ID: <53F245A4.5010106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/14 10:46, Doug Anderson wrote:
> Javier,
>
> On Mon, Aug 11, 2014 at 4:38 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk>  wrote:
>> The DeviceTree files for the Peach Pit and Pi machines have
>> a simplistic model of the connections between the different
>> regulators since not all the tps65090 regulators get their
>> input supply voltage from the VDC. DCDC1-3, LD0-1 and fet7
>> parent supply is indded VDC but the fet1-6 get their input
>> supply from the DCDC1 and DCDC2 output voltage rails.
>>
>> Update the DeviceTree to better reflect the real connections
>> between tps65090 regulators. Having this information in the
>> DTS is useful since FETs are switches that don't provide an
>> output voltage so the regulator core needs to fetch the FET
>> parent output voltage if the child voltage is queried.
>>
>> Signed-off-by: Javier Martinez Canillas<javier.martinez@collabora.co.uk>
>> Acked-by: Mark Brown<broonie@linaro.org>
>> ---
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts | 12 ++++++------
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts  | 12 ++++++------
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> Matches my schematics.  Kukjin: I think this could be applied to
> for-next whenever it's convenient.
>
OK, I've applied this but 2nd in this series...

> Acked-by: Doug Anderson<dianders@chromium.org>
>
Thanks,
Kukjin
