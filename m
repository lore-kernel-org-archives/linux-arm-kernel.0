From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 15 May 2018 22:32:37 +0300
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
Message-ID: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 05/11/2018 06:57 PM, Jeremy Linton wrote:

>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>> +       cache_size = of_get_property(np, propname, NULL);
>>         if (cache_size)
>>                 this_leaf->size = of_read_number(cache_size, 1);

Can't you switch to of_read_property_uXX() variant here?

>> -               line_size = of_get_property(this_leaf->of_node, propname,
>> NULL);
>> +               line_size = of_get_property(np, propname, NULL);

Ditto.

>>   -     nr_sets = of_get_property(this_leaf->of_node, propname, NULL);
>> +       nr_sets = of_get_property(np, propname, NULL);
>>         if (nr_sets)
>>                 this_leaf->number_of_sets = of_read_number(nr_sets, 1);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
