From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sat, 4 Jun 2011 01:05:16 +0300
Subject: [PATCH] omap: cleanup NAND platform data
In-Reply-To: <BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
References: <1307130993-15265-1-git-send-email-notasas@gmail.com>
	<BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
Message-ID: <BANLkTimXxOcr4q2fkD0hjq4pMVPC0StBFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2011 at 12:14 AM, Vimal Singh <vimal.newwork@gmail.com> wrote:
> On Sat, Jun 4, 2011 at 1:26 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>>
>> -static int omap2_nand_gpmc_retime(void)
>> +static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data)
>> ?{
>> ? ? ? ?struct gpmc_timings t;
>> ? ? ? ?int err;
>> @@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
>> ? ? ? ?return 0;
>> ?}
>>
>> -int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
>> +int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
>> ?{
>> ? ? ? ?int err = 0;
>> ? ? ? ?struct device *dev = &gpmc_nand_device.dev;
>>
>> - ? ? ? gpmc_nand_data = _nand_data;
>> - ? ? ? gpmc_nand_data->nand_setup = omap2_nand_gpmc_retime;
>
> Purpose of doing this was to be able to utilise
> 'omap2_nand_gpmc_retime', when DVFS is ready to use it,
> for changing timing parameter dynamically when a frequency change is done.

Well but it seems currently ...retime() only does single static
configuration, I guess when it's updated to do DVFS stuff callback can
easily be added back..
