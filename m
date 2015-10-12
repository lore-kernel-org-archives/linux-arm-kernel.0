From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 12 Oct 2015 15:12:17 +0100
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <20151010153744.GH29128@cbox>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <20151010153744.GH29128@cbox>
Message-ID: <561BBFC1.4070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej,

On 10/10/15 16:37, Christoffer Dall wrote:
> Hi Andre,
> 
> 
> On Wed, Oct 07, 2015 at 03:55:10PM +0100, Andre Przywara wrote:
>> Hi,
>>
>> another respin and rebase of the ITS emulation series.
>> Major changes compared to v2 (beside some minor things like added
>> comments and function renames) are the rebasing and adaption to 4.3-rc
>> and Christoffer's timer rework series. Also the locking has been
>> reworked to cope with the dependencies of the its and the dist lock
>> in connection with the PROPBASER/PENDBASER and the command handling.
>> For a more detailed changelog see below or look at the respective
>> commit messages.
>>
>> This should address most of the comments I got on the list.
>> Many thanks to the diligent reviewers!
>> I didn't bother to fine-tune patch 01/16 too much, as I guess there
>> will be more discussion around this based on Pavel's latest post.
>>
>> These patches go on top of Christoffer's timer rework series [1],
>> which itself is on top of 4.3-rc2.
>> You can find all of this code in the its-emul/v3 branch of my
>> repository [2].
> 
> Thanks for rebasing the series!
> 
> Just a heads up that I may not be able to review this series for the
> next 1-2 weeks, so I'm afraid it's not going to make it in for v4.4,
> sorry.
> 
> Please let me know if this breaks expectations from everyone.

No worries, I wasn't expecting this for 4.4 anyway.
I'd rather see the prerequisites like your timer series going upstream
first, I will then rebase it on top of 4.4-rc1 (with fixes from newer
review comments incorporated).
Maybe we can take Pavel's cleanup (replacing my 1/16 and 2/16) for 4.4
already? (I will reply on those soon)
Also what is the status of Eric's IRQ routing support? Should this go in
first now?

Cheers,
Andre.

> Othersie, I will try review it with due dilligence so it makes it in for
> v4.5.
> 
> Best,
> -Christoffer
