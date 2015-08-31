From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 31 Aug 2015 16:20:08 +0100
Subject: [PATCH v4] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
In-Reply-To: <BN3PR0301MB121977040608F337E69ADADEF5660@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <d556443a26070be505f9a5f5f0999253b73d9b71.1439283162.git.maitysanchayan@gmail.com>
 <9be567ec7d6f6370dd42a41438d64cf7aaa47635.1439826018.git.maitysanchayan@gmail.com>
 <BN3PR0301MB121977040608F337E69ADADEF5660@BN3PR0301MB1219.namprd03.prod.outlook.com>
Message-ID: <55E470A8.4000200@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/15 07:50, Duan Andy wrote:
> From: Sanchayan Maity <maitysanchayan@gmail.com> Sent: Monday, August 17, 2015 11:52 PM
>> To: jic23 at kernel.org; linux-iio at vger.kernel.org
>> Cc: stefan at agner.ch; Duan Fugang-B38611; pmeerw at pmeerw.net; linux-
>> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Sanchayan
>> Maity
>> Subject: [PATCH v4] iio: adc: vf610: Add IIO buffer support for Vybrid
>> ADC
>>
>> This patch adds support for IIO buffer to the Vybrid ADC driver.
>> IIO triggered buffer infrastructure along with iio sysfs trigger is used
>> to leverage continuous sampling support provided by the ADC block.
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> ---
>>
>> Changes since v3:
>> Fix iio_buffer_setup_ops for postenable and predisable functions to match
>> pairwise. Before this the predisable work was being done in postdisable.
>>
>> Changes since v2:
>> 1. Fix the wrong buffer size for statically allocated buffer 2. Drop the
>> use of .address field from the iio_chan_spec 3. Use iio_buffer_enabled
>> call inside the lock 4. Drop wrapper function around iio_trigered_*
>> function calls 5. Drop Kconfig select of sysfs trigger 6. Drop Kconfig
>> select IIO_TRIGGER as it is already selected by IIO_TRIGGERED_BUFFER
>>
>> Changes since v1:
>> 1. Use a fixed size buffer instead of kmalloc allocated during update
>> scan mode 2. Remove a write to read only register ADC_HS (COCO bit)
>>
>>  drivers/iio/adc/Kconfig     |   2 +
>>  drivers/iio/adc/vf610_adc.c | 105
>> +++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 100 insertions(+), 7 deletions(-)
>>
> 
> The version is fine for me. Thanks for your effort.
> 
> Acked-by: Fugang Duan <B38611@freescale.com>
Applied to the togreg branch of iio.git - will be initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
