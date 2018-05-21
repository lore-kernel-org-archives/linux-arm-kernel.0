From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 May 2018 10:27:11 +0100
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
 <20180517154701.GA20281@e107155-lin>
 <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
Message-ID: <7c9a4921-d4da-f1db-85ed-7d7f917be30c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/18 22:50, Andy Shevchenko wrote:
> On Thu, May 17, 2018 at 6:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> Is below patch does what you were looking for ?
> 
> Somewhat.
> See below for some minors.
> 

Thanks

>> of_property_read_u64 searches for a property in a device node and read
>> a 64-bit value from it. Instead of using of_get_property to get the
>> property and then read 64-bit value using of_read_number, we can make
>> use of of_property_read_u64.
> 
> Suggested-by?
>

Yes indeed, added it locally after I sent out this patch. Will send out
a proper patch soon.

>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> 
>> -       cache_size = of_get_property(np, propname, NULL);
>> -       if (cache_size)
>> -               this_leaf->size = of_read_number(cache_size, 1);
>> +       if (!of_property_read_u64(np, propname, &cache_size))
>> +               this_leaf->size = cache_size;
> 
> I suppose it's something like this
> 
> ret = of_property_...(..., &this_leaf->VAR);
> if (ret)
>  warning / set default / etc

OK, I do prefer this but once I was told not to use structure elements
directly like that, but should be harmless in this particular case, will
do so.

-- 
Regards,
Sudeep
