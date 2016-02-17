From: xuejiancheng@huawei.com (xuejiancheng)
Date: Wed, 17 Feb 2016 11:08:19 +0800
Subject: [RESEND PATCH v8 1/6] clk: hisilicon: add CRG driver for hi3519
 soc
In-Reply-To: <20160217004648.2278.64006@quark.deferred.io>
References: <1454639472-17373-1-git-send-email-xuejiancheng@huawei.com>
 <1454639472-17373-2-git-send-email-xuejiancheng@huawei.com>
 <20160217004648.2278.64006@quark.deferred.io>
Message-ID: <56C3E423.5080801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,
   Thank you very much for your comments.

On 2016/2/17 8:46, Michael Turquette wrote:
> Hello Jiancheng Xue,
> 
> Quoting Jiancheng Xue (2016-02-04 18:31:07)
>> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
>> index 74dba31..3f57b09 100644
>> --- a/drivers/clk/hisilicon/Makefile
>> +++ b/drivers/clk/hisilicon/Makefile
>> @@ -4,8 +4,10 @@
>>  
>>  obj-y  += clk.o clkgate-separated.o clkdivider-hi6220.o
>>  
>> +obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> 
> Do you really want to build reset.o for all hisi SoCs?
> 

This reset controller driver will be just used in some of hisilicon SOCs.
I'll add a specific config item for it like CONFIG_RESET_HISI. The config
item will be selected by default in SOCs needing this driver.

I'll also fix other issues in next version. Thank you!

Regards,
Jiancheng.
