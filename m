From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 11 Dec 2013 23:36:42 +0800
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <201312111549.14017.arnd@arndb.de>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <1386770541-15056-3-git-send-email-zhangfei.gao@linaro.org>
 <201312111549.14017.arnd@arndb.de>
Message-ID: <52A8868A.3000105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2013 10:49 PM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Zhangfei Gao wrote:

>> +Required Properties:
>> +
>> +* compatible: should be one of the following.
>> +  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.
>> +* clk-table-num: should be number of clks in clk-table required by each mmc timing
>> +* clk-table: should clock list required by each mmc timing
>
> I have not seen "clk-table" and "clk-table-num" before. Are these standard
> properties? What are the units that are used here, what does the index mean?
>

"clk-table" and "clk-table-num" are private properties.
Instead simply on/off, the ip need different ciu clock for each timing mode.
Take emmc as example,
clk-table-num = <8>;
clk-table =
<13000000 50000000 0 0 13000000 50000000 0 100000000>;
MMC_TIMING_LEGACY mode, 25M should be set with parent clock 180M,
MMC_TIMING_MMC_HS mode, 50M is required with parent clock 360M

"clk-table" list all clocks to be set in all supported timing one by one.
"clk-table-num" is the table number, since not find function getting 
table number.
For example, next version will support MMC_TIMING_MMC_HS200 mode, the 
clk-table-num = <9> with 9 clocks in the "clk-table"

Thanks
