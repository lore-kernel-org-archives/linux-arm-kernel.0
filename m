From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Wed, 20 Jan 2016 19:10:19 +0800
Subject: [PATCH v2 next-next] net: hns: enet specifies a reference to dsaf
In-Reply-To: <1453282570.2521.130.camel@linux.intel.com>
References: <1452654880-28980-1-git-send-email-yankejian@huawei.com>
 <56970F48.9060504@huawei.com> <1452764635.2521.28.camel@linux.intel.com>
 <569F2DEC.9040209@huawei.com> <1453282570.2521.130.camel@linux.intel.com>
Message-ID: <569F6B1B.6080902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/20 17:36, Andy Shevchenko wrote:
> On Wed, 2016-01-20 at 14:49 +0800, Yankejian (Hackim Yim) wrote:
>>>> +
>>>>>>> +	snprintf(ae_dev->name, AE_NAME_SIZE, "%s%d",
>>>>>>> DSAF_DEVICE_NAME,
>>>>>>> +		 (int)atomic_inc_return(&id));
>>> If you bind/unbind device enough times you may get an overflow and
>>> end
>>> up with name of existing device (if you have 1+ of them in the
>>> system).
>>>
>>> To avoid such situation better to use IDA/IDR framework.
>>>
>> Hi, Andy
>> Thanks again for your suggestion.
>> It seems that using IDA/IDR framework is better, but all of the
>> functions must be serialized by lock.
> AFAIR it's designed in a way you don't need to do any additional
> locking or synchronization.

really? if so, that is great.
could you sent me an example.
thanks very much. Andy.

Best Regards,
Kejian Yan
