From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 18 Jan 2017 02:07:24 +0200
Subject: [PATCH net-next v4 05/10] drivers: base: Add
 device_find_in_class_name()
In-Reply-To: <e3132d31-f94f-8794-1121-0fe25be2f61b@gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170117232152.1661-6-f.fainelli@gmail.com>
 <CAHp75VfE8t+_2Yu1NYMErKopnCNwFakO6pyDRmqAU-ZsGuyvmg@mail.gmail.com>
 <b8cc0d2f-f544-0e06-32bd-47e6b9be5393@gmail.com>
 <CAHp75Ve9xn6wDxFwnkPDyY8yVwVysK3-pUsoxv3GfVbbEVZoBg@mail.gmail.com>
 <e3132d31-f94f-8794-1121-0fe25be2f61b@gmail.com>
Message-ID: <CAHp75VeqLb2hDgj2jfWzQgw4wa31gckSw=jZS0UhUAnZgNA14Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 2:04 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 01/17/2017 04:00 PM, Andy Shevchenko wrote:
>> On Wed, Jan 18, 2017 at 1:43 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 01/17/2017 03:34 PM, Andy Shevchenko wrote:
>>>> On Wed, Jan 18, 2017 at 1:21 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:

>> But why not to use void *class_name to be consistent with callback and
>> device_find_child()?
>
> The top-level function: device_find_in_class_name() should have a
> stronger typing of its argument even if it internally uses
> device_find_child() and a callback that takes a void * argument, that's
> how I see it.

Fair enough.

>> Btw,
>> return get_device(parent);
>
> Not sure I follow what that means here?

Missed remark. Instead of

get_device(parent);
return parent;

you can use

return get_device(parent);

-- 
With Best Regards,
Andy Shevchenko
