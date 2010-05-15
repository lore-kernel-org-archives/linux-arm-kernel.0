From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 15 May 2010 11:36:20 +0300
Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
In-Reply-To: <AANLkTinzSJjupRMGWmlB6cyGpYMm5tpPvhcMFdROZNCL@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<AANLkTildHTovAq6DZa2nPgYwX3BHsHuvM9oKGFssFH6-@mail.gmail.com>
	<AANLkTinzSJjupRMGWmlB6cyGpYMm5tpPvhcMFdROZNCL@mail.gmail.com>
Message-ID: <AANLkTimC2IoWwfqvnVMKgVeZ7iyx6quwRgYXEgjXZ6pP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, May 14, 2010 at 10:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, May 14, 2010 at 6:09 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Hi Felipe,
>>
>> On Fri, May 14, 2010 at 6:01 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> The main purpose of this patch series is to be able to compile mach platform
>>> data as built-in. Otherwise, client modules such as bridgedriver will load the
>>> platform code, but not the mach code when mailbox is built as a module.
>>>
>>> Unfortunately, there's no easy way to do that since plat and mach code are
>>> deepely interrelated. So the first patches try to separate the mailbox
>>> registering through a defined omap_mbox_platform_data.
>>
>> Have you considered converting mailbox to hwmod + omap_device ?
>
> I don't know what's that... so no. Is there any good source of
> information, or a good example?

A good example (that also demonstrates runtime PM conversion)
would be the MMC conversion in Kevin's 'pm-wip/mmc' branch:

http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=log;h=pm-wip/mmc

> I think there is further tidying up
> possible after this patch series independent of that, but I would like
> to concentrate on getting this in first.

Sure thing.

Thanks,
Ohad.

>
> --
> Felipe Contreras
>
