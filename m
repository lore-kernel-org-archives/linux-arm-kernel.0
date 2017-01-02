From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 02 Jan 2017 20:02:29 +0800
Subject: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <CAJZ5v0h3d5ZUxJXhgz74fSDR=AKTg_Of2knaONF_e2dr6Q-PsA@mail.gmail.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
 <585E24FB.9050805@huawei.com>
 <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
 <586072E9.3060609@huawei.com> <58663C04.9000603@huawei.com>
 <CAJZ5v0h3d5ZUxJXhgz74fSDR=AKTg_Of2knaONF_e2dr6Q-PsA@mail.gmail.com>
Message-ID: <586A4155.3090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/01/2017 04:45 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 30, 2016 at 11:50 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
[...]
>>
>> So how about just add the code as below?
>
> Works for me.

OK, will send out the updated patch set soon.

>
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> index 11e63dd..37a8dfe 100644
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -316,7 +316,8 @@ static int acpi_platform_notify(struct device *dev)
>>          if (!adev)
>>                  goto out;
>>
>> + if (dev->bus == &platform_bus_type)
>> +         acpi_configure_pmsi_domain(dev);
>>
>>          if (type && type->setup)
>>                  type->setup(dev);

Thanks for your comments.

Hanjun
