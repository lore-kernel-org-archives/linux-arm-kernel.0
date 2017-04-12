From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 12 Apr 2017 12:24:26 -0700
Subject: [PATCH -next] imx7: fix Kconfig warning and build errors
In-Reply-To: <CAOMZO5CF4GZx2UWxq3SF_=g9hnSS9A28T4tPLaSHQr-qJs623Q@mail.gmail.com>
References: <47fc2167-bf0a-866a-e075-8247a10aa6e0@infradead.org>
 <CAOMZO5CF4GZx2UWxq3SF_=g9hnSS9A28T4tPLaSHQr-qJs623Q@mail.gmail.com>
Message-ID: <8f538f2f-320a-78bb-1008-8e27908f8cf9@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/17 11:26, Fabio Estevam wrote:
> On Wed, Apr 12, 2017 at 3:22 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> --- linux-next-20170412.orig/drivers/soc/imx/Kconfig
>> +++ linux-next-20170412/drivers/soc/imx/Kconfig
>> @@ -2,6 +2,7 @@ menu "i.MX SoC drivers"
>>
>>  config IMX7_PM_DOMAINS
>>         bool "i.MX7 PM domains"
>> +       depends on PM
>>         select PM_GENERIC_DOMAINS
> 
> Could this be:
> 
> select PM_GENERIC_DOMAINS if PM instead?
> 

You want IMX7_PM_DOMAINS to be built without having
PM_GENERIC_DOMAINS enabled?

On x86, your suggestion works for me... because of this
in drivers/soc/Makefile:

obj-$(CONFIG_ARCH_MXC)		+= imx/

and I don't have CONFIG_ARCH_MXC, so the gpc* binaries are
not being built at all.  This might be a small bug.


-- 
~Randy
