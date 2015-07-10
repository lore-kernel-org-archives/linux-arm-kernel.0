From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 10 Jul 2015 12:11:38 +0800
Subject: question about i2c-designware
In-Reply-To: <559E37D7.6040103@huawei.com>
References: <559E37D7.6040103@huawei.com>
Message-ID: <559F45FA.8060801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-arm-kernel at lists.infradead.org

On 2015-07-09 16:59, Kefeng Wang wrote:
> Hi all,
> 
>   We met a issue when use Synopsys DesignWare I2C. The SDA will keep low level and never go back to the high level
> if both i2c controllers simultaneously access the same i2c device(rtc), then both two i2c controllers can't send any data.
> we try to reset the rtc, but not working. After reset the i2c controller, the SDA goes back to the high state and we
> can get time from rtc again.
> 
> The scenario is as follows, any advice will be appreciated.
> 
>                    OS 1         |     OS 2
>                                 |
> 	+--------------+----------|--------------+
> 	|	       |	  |              |
> 	|    +---------|----+-----|---------+    |
> 	|    |	       |    |     |         |    |
>    ----------------    ------	  |    -----------------
>    |i2c controller1|   | rtc|	  |    |i2c controller2|
>    ----------------    ------   |    -----------------
>                                 |
> note:
> 1) i2c controller1 and controller2 use same IP.
> 2) OS1 use v3.19 and OS2 use 2.6
> 
> Thanks
> Kefeng
> 
