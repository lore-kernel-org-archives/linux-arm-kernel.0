From: xiyou.wangcong@gmail.com (Cong Wang)
Date: Wed, 07 Mar 2012 12:55:37 +0800
Subject: [PATCH v3] MM: CMA: add a simple kernel module as the helper
 to test CMA
In-Reply-To: <CAGsJ_4x4CwD+WAE9d+Xob_tfwqmE6SdBdBd5EbC64XBi4Uzvgg@mail.gmail.com>
References: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
 <4F56E0AC.8070501@gmail.com>
 <CAGsJ_4x4CwD+WAE9d+Xob_tfwqmE6SdBdBd5EbC64XBi4Uzvgg@mail.gmail.com>
Message-ID: <4F56EA49.8070808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2012 12:49 PM, Barry Song wrote:
> 2012/3/7 Cong Wang<xiyou.wangcong@gmail.com>:
>> On 03/07/2012 11:14 AM, Barry Song wrote:
>>>
>>> From: Barry Song<Baohua.Song@csr.com>
>>>
>>> Any write request to /dev/cma_test will let the module to allocate memory
>>> from
>>> CMA, for example:
>>>
>>> 1st time
>>> $ echo 1024>    /dev/cma_test
>>> will require cma_test to request 1MB(1024KB)
>>> 2nd time
>>> $ echo 2048>    /dev/cma_test
>>> will require cma_test to request 2MB(2048KB)
>>>
>>> Any read request to /dev/cma_test will let the module to free the 1st
>>> valid
>>> memory from CMA, for example:
>>>
>>> 1st time
>>> $ cat /dev/cma_test
>>> will require cma_test to free the 1MB allocated in the first write request
>>> 2nd time
>>> $ cat /dev/cma_test
>>> will require cma_test to free the 2MB allocated in the second write
>>> request
>>
>>
>> Any reason why using /dev not /proc or /sys?
>
> pls note it is just a test module to verify CMA at runtime. it is not
> important either it is /dev, it is /proc or it is /sys.

Why not important? You want it to be merged, don't you?

>
> any way to make things easier, we take that way.
>

Why /dev interface is easier than /proc and /sys? Confused, actually I 
think /proc or /sys should be easier...
