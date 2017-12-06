From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 6 Dec 2017 17:41:32 +0100
Subject: [PATCH] ACPI / GED: unregister interrupts during shutdown
In-Reply-To: <aa5bcbab-b059-1abf-1553-371fe5750455@codeaurora.org>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com>
 <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
 <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
 <fe65ff1a-a8b8-c29b-161d-72cbfea5c056@codeaurora.org>
 <aa5bcbab-b059-1abf-1553-371fe5750455@codeaurora.org>
Message-ID: <CAJZ5v0iifeFpJsSwXO1AGLW3rn1cG7t3V6ZAnu34-K=D_DavBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 5:11 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/6/2017 9:57 AM, Sinan Kaya wrote:
>>> Yes, it should, so I'm not sure why you need the list in the first place.
>>>
>>> Also it looks like something along the lines of devres_release_all()
>>> should be sufficient.
>> Good suggestion, let me test this.
>>
>
> I tried to pull the code into GED but the API is not public. I also looked
> at how it is used. I was afraid to mess up with the internals of base.c by
> calling devres_release_all() externally first and by the driver framework
> next. I moved away from this approach.

Are you sure it is called by the core in the shutdown path?

> I just fixed the function rename and changed the dev_info() to dev_dbg().

And why do you need the list?

ged_shutdown() will be called for every device for which ged_probe()
has been called.
