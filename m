From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 4 Dec 2013 10:28:58 +0800
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <CAPcyv4gCge1n99c8NGr1=L+PzBCxyWMJvDDQFp-T+mcCRMSMng@mail.gmail.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
 <CAMj5Bkjk6v_2Op1oph8GGw2mf8w40c-L3JhBRPNsRewiFxQHpw@mail.gmail.com>
 <529C37F3.1040205@marvell.com>
 <CAPcyv4jfk+JBv7WY_njuYtx8hERZHhoCAij=FOfqxAhLJAHnFA@mail.gmail.com>
 <CAMj5Bkjkndq1-AJSm0k9Mm8xeaWEGktoFb6nZ3kr7RackFdcaw@mail.gmail.com>
 <529D4273.10602@gmail.com>	<529DB5C8.1010500@marvell.com>
 <CAA9_cmc0+onxBJ4_xRAPSfH2Hx6ky87EZk9_8kJvbED03_Ca1g@mail.gmail.com>
 <529E8087.2080106@marvell.com>
 <CAPcyv4g93i+kZXBzfEKrav-=C2jYL=KXgp4W+Bw9zr0yhLdP0w@mail.gmail.com>
 <529E8C4C.4010107@marvell.com>
 <CAPcyv4gCge1n99c8NGr1=L+PzBCxyWMJvDDQFp-T+mcCRMSMng@mail.gmail.com>
Message-ID: <529E936A.9080203@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 10:15 AM, Dan Williams wrote:
> On Tue, Dec 3, 2013 at 5:58 PM, Qiao Zhou <zhouqiao@marvell.com> wrote:
>> On 12/04/2013 09:32 AM, Dan Williams wrote:
>>>
>>> Please read the question, you can refer to of_get_named_gen_pool() for
>>> why I have a question.  Something in the system needs to do the
>>> devm_gen_pool_create() for that device.  If you are removing the mmp2
>>> sram driver are you switching to the generic sram driver?  If so
>>> shouldn't you ensure it is built? Otherwise this will always fail:
>>
>> For CPU_MMP2 specifically, it switches to use generic sram driver. But
>> generally it may not use sram only, a DDR buffer(or other buffer) may also
>> be a pool. So here we don't add "select SRAM" directly. In this case we need
>> to enable CONFIG_SRAM in mmp2_defconfig.
>>
>> If no sram or other similar drivers are enabled, it will throw an error for
>> warning.
>>
>
> Ok, So, please turn this into a compile time dependency (depends on
> (SRAM || MMP_SRAM)) so that someone does not need to boot a platform
> to figure out they forgot to enable a driver.
>
Actually I'm not sure it's good to add such dependency. 
sound/core/memalloc.c provides the same way for sram buffer allocation. 
It doesn't add such dependency.

Zhangfei, Haojian, how do you think?

-- 

Best Regards
Qiao
