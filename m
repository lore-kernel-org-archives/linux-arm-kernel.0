From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 27 Aug 2013 10:04:48 +0800
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <20130820081348.GV4713@mwanda>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
 <20130819052516.GT32147@intel.com>
 <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
 <20130820081348.GV4713@mwanda>
Message-ID: <521C0940.9000408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-20 04:13 PM, Dan Carpenter wrote:
> On Tue, Aug 20, 2013 at 03:58:41PM +0800, zhangfei gao wrote:
>
>> BTW, it is strange I do not see such compile warning here :(
>
> This was a Smatch static checker warning, not a regular build
> warning.
>
> regards,
> dan carpenter
>
Dear Dan

Thanks for introducing this valuable tool.
Have download from git://repo.or.cz/smatch.git

When trying use this tool, could get some warning,
make CHECK="~/bin/smatch -p=kernel --no-data" C=1 | tee warns.txt

Also some strange warning, like "SQL error #2: no such table: 
caller_info", is it ignored?

Besides, when test this case for check smatch setting.
Still not reproduce the issue, should be not config correct?

Only get
drivers/dma/dmaengine.c:845 dma_async_device_register() warn: possible 
memory leak of 'idr_ref'
drivers/dma/dmaengine.c:866 dma_async_device_register() warn: possible 
memory leak of 'idr_ref'

Anyway, though config not totally correct, it really could find some 
warning.

Thanks
