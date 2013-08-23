From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 20:34:17 +0200
Subject: [PATCH v4 1/5] net: ethernet: cpsw: switch to devres allocations
In-Reply-To: <5217A5AE.6090704@cogentembedded.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-2-git-send-email-zonque@gmail.com>
 <5217A5AE.6090704@cogentembedded.com>
Message-ID: <5217AB29.9020209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 20:10, Sergei Shtylyov wrote:
> On 08/23/2013 06:16 PM, Daniel Mack wrote:

>>   	priv->coal_intvl = 0;
>>   	priv->bus_freq_mhz = clk_get_rate(priv->clk) / 1000000;
>>
>> -	priv->cpsw_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!priv->cpsw_res) {
>> +	ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!ss_res) {
> 
>     You don't need to check the result of platform_get_resource() if you call
> devm_ioremap_resource() right afterwards -- it will check resource ptr for 
> NULL the first thing. :-)

Thanks! Will address that in v5.


Daniel
