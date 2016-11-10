From: joel@jms.id.au (Joel Stanley)
Date: Thu, 10 Nov 2016 13:16:13 +1030
Subject: [PATCH 3/3] ipmi/bt-bmc: add a sysfs file to configure a maximum
 response time
In-Reply-To: <7e7e5cde-341a-ecca-9c9c-b41695703b08@acm.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-4-git-send-email-clg@kaod.org>
 <3a1f8e6d-c935-3404-ffa0-81b19d170731@acm.org>
 <aa4804b0-4084-6d34-c1db-68bdb5efb20a@kaod.org>
 <7e7e5cde-341a-ecca-9c9c-b41695703b08@acm.org>
Message-ID: <CACPK8XdiBFvPo5toh0UcPtOzx2XhhXC-EMgpj4mitfo3Samw8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 2:34 AM, Corey Minyard <minyard@acm.org> wrote:
> On 11/09/2016 08:42 AM, C?dric Le Goater wrote:
>> The patch raises a few questions on the "BT Interface Capabilities" :
>>
>>   - should we use sysfs or a specific ioctl to configure the driver ?
>
>
> I should probably say sysfs, but really I don't care.  The hard part about
> ioctls is the compat, and there shouldn't be any compat issues with this
> interface.  An ioctl is probably easier, especially if you add an ioctl for
> the header size thing I talked about in the previous email.
>
> The only thing that matters to the driver is the timeout.  If you want to
> make the timeout per fd, then it will have to be an ioctl.

I vote for an ioctl as it's simpler for userspace.

In another driver we use on the BMCs we have a character device and a
few sysfs files for configuration. This means userspace needs to
discover and open > 1 fd, which is annoying.

Cheers,

Joel

>>   - should the driver handle directly the response to the "Get BT
>>     Interface Capabilities" command ?
>
>
> That probably belongs in userspace.  The only reason I can think of
> to have it in the driver would be so the host driver can fetch it if the
> BMC userspace is down, but I can't see how that's a good idea.
>
> Hope my wishy-washy answer helps :-).
