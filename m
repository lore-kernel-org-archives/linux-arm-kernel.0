From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:48:56 +0100
Subject: [PATCH v6 8/9] nvmem: sunxi: Move the SID driver to the nvmem
 framework
In-Reply-To: <1335062615.252618.1435092272970.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014583-26478-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1335062615.252618.1435092272970.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7D08.1000403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 21:44, Stefan Wahren wrote:
>
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 23. Juni 2015 um
>> 01:09 geschrieben:
>>
>>
>> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Now that we have the nvmem framework, we can consolidate the common
>> driver code. Move the driver to the framework, and hopefully, it will
>> fix the sysfs file creation race.
>> --- /dev/null
>> +++ b/drivers/nvmem/sunxi-sid.c
>> [...]
>> +
>> +static int sunxi_sid_write(void *context, const void *data, size_t count)
>> +{
>> + /* Unimplemented */
>> + return 0;
>> +}
>> +
>
> I think it should be clear that the write operation isn't implemented. It's more
> important to know the function should make
> regmap_init happy.


I totally agree with you.. It was just to make regmap_init happy. Indeed 
I thought of adding this comment, but forgot over the time :-) I will 
fix it.

--srini


> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
