From: davem@davemloft.net (David Miller)
Date: Fri, 06 Jun 2014 01:24:24 -0700 (PDT)
Subject: [PATCH v4 2/2] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <20140606081917.GD31915@ulmo>
References: <1401774577-16683-1-git-send-email-zhangfei.gao@linaro.org>
 <1401774577-16683-3-git-send-email-zhangfei.gao@linaro.org>
 <20140606081917.GD31915@ulmo>
Message-ID: <20140606.012424.2191719134344576181.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 6 Jun 2014 10:19:18 +0200

> On Tue, Jun 03, 2014 at 01:49:37PM +0800, Zhangfei Gao wrote:
> [...]
>> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
>> new file mode 100644
>> index 0000000..e942173
>> --- /dev/null
>> +++ b/drivers/net/ethernet/hisilicon/Kconfig
>> @@ -0,0 +1,27 @@
>> +#
>> +# HISILICON device configuration
>> +#
>> +
>> +config NET_VENDOR_HISILICON
>> +	bool "Hisilicon devices"
>> +	default y
> 
> Can this default please be dropped? It's annoying because it will cause
> this driver to be built for *every* ARM kernel by default, whether or
> not that hardware is available on a given board.

People mistakedly say this every time, this config option is not for
the driver, it's a VENDOR guard.
