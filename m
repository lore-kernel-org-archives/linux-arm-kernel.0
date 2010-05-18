From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 18 May 2010 19:57:55 +0300
Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
In-Reply-To: <20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
	<AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
	<20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTik_FL2keLD9mdBcg8Rm9n8uYDElg1NdyeT2yy6B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 4:31 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> I'm not familiar with this kind of module loading, but certainly not
>> all systems have udev.
>>
>> I realized the problem because I have a bare-bones system in my
>> beagleboard where I had to manually load mailbox_mach.
>
> With udev or something equivalent, it should work fine.

But still, you are relying on udev. I don't think we should, and I
don't think there's any need.

>>> The platform device omap2-mailbox accomodatess logical mboxes.
>>
>> Wouldn't it be better the way my patches handle them?
>> ?* devices.ko: ?doesn't care about mbox
>> ?* mach_omap1/mailbox.ko: ?registers "omap-mailbox" platform device
>> with a list of logical mboxes for OMAP1
>> ?* mach_omap2/mailbox.ko: ?registers "omap-mailbox" platform device
>> with a list of logical mboxes for OMAP2
>> ?* plat-omap/mailbox.ko: creates platform driver based on logical list
>> of mboxes from platform device and handles the list internally
>>
>> The end result would be the exactly same, except that there's no hard
>> dependency between the mach, and plat code.
>
> With the attachemnt, which is just 17 lines of code, you will get the
> structure of logical mbox devices, which are located under the single
> platform device, "omap2-mailbox". This is more _descriptive_ since
> it displays the connection of a platform device and logical devices,
> IOW, where these logical ones come. I don't see any point of not using
> this struture.

That's neat. Am I understanding correctly that that's not an argument
against the split of mailbox_mach and plat mailbox?

>>> Would it be possible to rebase them on the top of my coming patch to
>>> get back logical device entry?
>>
>> Where is that?
>
> Attached. Would it be possible to rebase the cleanups on this one?

I think it would be easier to apply the patch on top of my patch
series... specially since it's so small. Would that be acceptable?

-- 
Felipe Contreras
