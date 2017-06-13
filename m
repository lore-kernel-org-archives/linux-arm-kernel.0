From: jiada_wang@mentor.com (Jiada Wang)
Date: Tue, 13 Jun 2017 14:28:03 +0900
Subject: [PATCH linux-next v4 2/4] spi: imx: add selection for iMX53 and
 iMX6 controller
In-Reply-To: <20170612155345.qtgaq4wjj2vidohd@rob-hp-laptop>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
 <20170608051603.16070-3-jiada_wang@mentor.com>
 <20170612155345.qtgaq4wjj2vidohd@rob-hp-laptop>
Message-ID: <a4d5d8e2-c50d-4856-e14f-34ead774824e@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob

On 06/13/2017 12:53 AM, Rob Herring wrote:
> On Thu, Jun 08, 2017 at 02:16:01PM +0900, Jiada Wang wrote:
>> ECSPI contorller for iMX53 and iMX6 has few hardware issues
>> comparing to iMX51.
>> The change add possibility to detect which controller is used
>> to apply possible workaround and limitations.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>>  drivers/spi/spi-imx.c                              | 26 ++++++++++++++++++++--
>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
>> index 31b5b21..5bf1396 100644
>> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
>> @@ -9,6 +9,7 @@ Required properties:
>>    - "fsl,imx31-cspi" for SPI compatible with the one integrated on i.MX31
>>    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>>    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
>> +  - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
>>  - reg : Offset and length of the register set for the device
>>  - interrupts : Should contain CSPI/eCSPI interrupt
>>  - cs-gpios : Specifies the gpio pins to be used for chipselects.
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 4469121..8e6f339 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -63,7 +63,8 @@ enum spi_imx_devtype {
>>  	IMX27_CSPI,
>>  	IMX31_CSPI,
>>  	IMX35_CSPI,	/* CSPI on all i.mx except above */
>> -	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
>> +	IMX51_ECSPI,	/* ECSPI on i.mx51 */
>> +	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
>
> Looks like i.MX51 and i.MX53 are the same. While the DT should have
> different compatibles (with fallbacks), the driver should map them to
> the same type until there's some difference found.
>
the difference between i.MX51 and i.MX53 is introduced in the
4th patch "spi: imx: Add support for SPI Slave mode" in this patch set

do you think, I need to merge the two patches into one?

Thanks,
Jiada

> Rob
>
