From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 30 Jul 2018 15:45:05 -0700
Subject: [PATCH v7 11/12] hwmon: Add PECI dimmtemp driver
In-Reply-To: <CAL_JsqK4k=c6k-BJT5fWQH_DCqGhr13fq6M_iZZehaveE-z5Hg@mail.gmail.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-12-jae.hyun.yoo@linux.intel.com>
 <CAL_JsqK4k=c6k-BJT5fWQH_DCqGhr13fq6M_iZZehaveE-z5Hg@mail.gmail.com>
Message-ID: <f3056c4d-1cc6-5fcd-f185-f6b0878e6326@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 7/30/2018 3:06 PM, Rob Herring wrote:
> On Mon, Jul 23, 2018 at 3:49 PM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit adds PECI dimmtemp hwmon driver.
>>
> 
>> +#if IS_ENABLED(CONFIG_OF)
>> +static const struct of_device_id peci_dimmtemp_of_table[] = {
>> +       { .compatible = "intel,peci-dimmtemp" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, peci_dimmtemp_of_table);
>> +#endif
> 
> This should be removed. Same for cpu temp driver I'm guessing.
> 

Yes, you are right. This isn't needed anymore because MFD driver
loads this module. I'll remove this code from here and from cpu temp
driver. Also, I'll remove 'of_compatible' setting of 'struct mfd_cell
peci_functions' in intel-peci-client.c code.

Thanks a lot for your pointing it out!

Jae

> Rob
> 
