From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 18 Jan 2017 02:00:25 +0200
Subject: [PATCH net-next v4 05/10] drivers: base: Add
 device_find_in_class_name()
In-Reply-To: <b8cc0d2f-f544-0e06-32bd-47e6b9be5393@gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170117232152.1661-6-f.fainelli@gmail.com>
 <CAHp75VfE8t+_2Yu1NYMErKopnCNwFakO6pyDRmqAU-ZsGuyvmg@mail.gmail.com>
 <b8cc0d2f-f544-0e06-32bd-47e6b9be5393@gmail.com>
Message-ID: <CAHp75Ve9xn6wDxFwnkPDyY8yVwVysK3-pUsoxv3GfVbbEVZoBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 1:43 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 01/17/2017 03:34 PM, Andy Shevchenko wrote:
>> On Wed, Jan 18, 2017 at 1:21 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:

>>> +static int device_class_name_match(struct device *dev, void *class)
>>
>> And why not const char *class?
>
> This was raised back in v2, and the same response applies:
>
> https://www.mail-archive.com/netdev at vger.kernel.org/msg147559.html
>
> Changing the signature of a callback is out of the scope of this patch
> series.

Ah, right.

But why not to use void *class_name to be consistent with callback and
device_find_child()?

Btw,

return get_device(parent);

-- 
With Best Regards,
Andy Shevchenko
