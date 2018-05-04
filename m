From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 4 May 2018 09:56:10 +0800
Subject: [PATCH 1/3] spi: meson-axg: support MAX 80M clock
In-Reply-To: <20180503231305.GC13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-2-yixun.lan@amlogic.com>
 <20180503231305.GC13402@sirena.org.uk>
Message-ID: <6cdee2c8-2ca4-2efb-43ac-c233516c0570@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On 05/04/18 07:13, Mark Brown wrote:
> On Thu, May 03, 2018 at 09:36:42PM +0000, Yixun Lan wrote:
> 
>>  static const struct of_device_id meson_spicc_of_match[] = {
>> -	{ .compatible = "amlogic,meson-gx-spicc", },
>> -	{ .compatible = "amlogic,meson-axg-spicc", },
>> +	{
>> +		.compatible	= "amlogic,meson-gx-spicc",
>> +		.data		= &meson_spicc_gx_data,
>> +	},
>> +	{
>> +		.compatible = "amlogic,meson-axg-spicc",
>> +		.data		= &meson_spicc_axg_data,
>> +	},
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
> 
> This is changing the DT bindings but there's no update to the DT binding
> documentation, please add an update there.
> 

thanks for your comments, but I actually didn't get what's your point here.

Here I only introduce the dt compatible data to differentiate the
old/new controller, the compatible name is not changed, and none of the
property is introduced.

Yixun
