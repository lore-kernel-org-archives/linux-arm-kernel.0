From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 16 Jan 2014 20:34:47 +0800
Subject: [PATCH v2] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <201401161150.34258.arnd@arndb.de>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
 <201401161150.34258.arnd@arndb.de>
Message-ID: <52D7D1E7.80502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/16/2014 06:50 PM, Arnd Bergmann wrote:
> On Thursday 16 January 2014, Zhangfei Gao wrote:
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -73,6 +73,8 @@ Optional properties:
>>
>>   * caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
>>
>> +* caps2-mmc-cd-active-high: cd pin is high when card present
>> +
>>   * broken-cd: as documented in mmc core bindings.
>>
>>   * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>
> No, don't introduce a new flag when there is already one defined
> in the generic mmc binding.

Got it.

Update with "cd-inverted".

      if (of_get_property(np, "cd-inverted", NULL))
                 pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;


Thanks
