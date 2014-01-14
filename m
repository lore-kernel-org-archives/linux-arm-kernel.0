From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 14 Jan 2014 17:47:57 +0800
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <002801cf110c$731fd720$595f8560$%jun@samsung.com>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
 <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com>
 <52CFFFDA.8050108@linaro.org>
 <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com>
 <52D3515B.7040008@linaro.org>
 <001c01cf1020$e3e1aed0$aba50c70$%jun@samsung.com>
 <52D3A43B.4030909@linaro.org>
 <002801cf110c$731fd720$595f8560$%jun@samsung.com>
Message-ID: <52D507CD.8040900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Seungwon

On 01/14/2014 05:38 PM, Seungwon Jeon wrote:

>> Looks like you dislike the clk_table very much :)
> Oh, I just want to remove dependency as I mentioned.
> 
>>
>> Double checked with the silicon guy, currently it is said the limitation
>> in HS200 and SDR104 can be replaced by the max_rate, so clk_table can be
>> replaced with ios->clock directly, though they have concern it is not so
>> convinent when removing clk_table in case limitation rate is not equal
>> to max_rate again in future.
> I guess specific clock handling(clk-hi3620.c) can adjust required source clock rate.
> 
It is doable now since the soc has been updated with the limitation,
which can reuse max_rate now.
The patch "mmc: dw_mmc: k3 remove clk_table" has been updated, and have
modified clk-hi3620.c accordingly.

Thanks
