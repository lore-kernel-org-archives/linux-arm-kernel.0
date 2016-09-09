From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 Sep 2016 07:46:10 -0700
Subject: next-20160909 build: 1 failures 0 warnings (next-20160909)
In-Reply-To: <3281448.mbmBk67UZ8@wuerfel>
References: <E1biHa1-0004JG-Om@optimist>
 <20160909101407.GA27946@sirena.org.uk> <3281448.mbmBk67UZ8@wuerfel>
Message-ID: <faa7153f-8e43-b03a-cda5-3fa0750b30c5@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2016 03:56 AM, Arnd Bergmann wrote:
> On Friday, September 9, 2016 11:14:07 AM CEST Mark Brown wrote:
>> On Fri, Sep 09, 2016 at 09:54:37AM +0100, Build bot for Mark Brown wrote:
>>
>> Since yesterday -next has been failing to build an arm64 allmodconfig
>> due to:
>>
>>> 	arm64-allmodconfig
>>> ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!
>>
>> caused by 05dbf57876b97d2 (hwmon: Add xgene hwmon driver).  That symbol
>> is not exported so can't be used from modules though I can't immediately
>> see how that module acquired a reference to that symbol.
>
> See also https://lkml.org/lkml/2016/9/8/311
>
> I haven't done a patch since we're still debating about how to best
> address this.
>

Until there is a solution, I'll mark the xgene driver as BROKEN. Though I really
think it is the victim here, not the culprit.

Guenter
