From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 6 Dec 2017 14:37:29 +0100
Subject: [PATCH] ACPI / GED: unregister interrupts during shutdown
In-Reply-To: <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com>
 <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
Message-ID: <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 2:24 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 12/5/2017 5:18 PM, Rafael J. Wysocki wrote:
>> On Tue, Dec 5, 2017 at 10:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> Some GED interrupts could be pending by the time we are doing a reboot.

[cut]

>
>>
>>>         .probe = ged_probe,
>>>         .driver = {
>>>                 .name = MODULE_NAME,
>>> --
>>
>> Overall, it looks like we should just unbind the driver from all
>> devices on shutdown.
>
> I see that shutdown is getting called on all GED instances. That should
> take care of it, right?

Yes, it should, so I'm not sure why you need the list in the first place.

Also it looks like something along the lines of devres_release_all()
should be sufficient.

Thanks,
Rafael
