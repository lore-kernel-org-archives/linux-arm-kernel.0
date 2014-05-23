From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 23 May 2014 11:15:18 +0800
Subject: [PATCH v2 2/3] [media] atmel-isi: convert the pdata from pointer
 to structure
In-Reply-To: <Pine.LNX.4.64.1405182255540.23804@axis700.grange>
References: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
 <1395744087-5753-3-git-send-email-josh.wu@atmel.com>
 <Pine.LNX.4.64.1405182255540.23804@axis700.grange>
Message-ID: <537EBD46.6030406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Guennadi

On 5/19/2014 4:59 AM, Guennadi Liakhovetski wrote:
> Hi Josh,
>
> I'm still waiting for an update of Ben's patches to then also apply yours,
> but I decided to have a look at yours now to see if I find anything, that
> might be worth changing. A small note to this one below.
>
> On Tue, 25 Mar 2014, Josh Wu wrote:
>
>> Now the platform data is initialized by allocation of isi
>> structure. In the future, we use pdata to store the dt parameters.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>> v1 --> v2:
>>   no change.
>>
>>   drivers/media/platform/soc_camera/atmel-isi.c |   22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
>> index 9d977c5..f4add0a 100644
>> --- a/drivers/media/platform/soc_camera/atmel-isi.c
>> +++ b/drivers/media/platform/soc_camera/atmel-isi.c
> [snip]
>
>> @@ -912,7 +912,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
>>   	if (IS_ERR(isi->pclk))
>>   		return PTR_ERR(isi->pclk);
>>   
>> -	isi->pdata = pdata;
>> +	memcpy(&isi->pdata, pdata, sizeof(struct isi_platform_data));
> I think it'd be better to use
>
> +	memcpy(&isi->pdata, pdata, sizeof(isi->pdata));
>
> This way if the type of the pdata changes at any time in the future this
> line will not have to be changed. If you don't mind I can make this change
> myself, so you don't have to make a new version just for this.

Thanks for pointing it out.  I think I will sent out a new version of 
patch (include bus-width parsing) then I will included with this fix.

Best Regards,
Josh Wu

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
