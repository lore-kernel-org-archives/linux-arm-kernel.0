From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Thu, 01 Dec 2016 12:18:26 +0100
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.10
In-Reply-To: <23121827.vnVDrZQAeV@wuerfel>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
 <23121827.vnVDrZQAeV@wuerfel>
Message-ID: <fa48be7a336e97c850b226d0c54c9b96@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-30 17:52, Arnd Bergmann wrote:
> On Monday, November 21, 2016 9:48:19 PM CET Florian Fainelli wrote:
>> This pull request contains Broadcom ARM-based SoC changes for 4.10, 
>> please pull
>> the following:
>> 
>> - Rafal adds back the abort handler hook on BCM5301x which is required 
>> to silence
>>   errors forwared from the PCIe controller that cannot be silenced at 
>> the PCIe RC level
>> 
> 
> Pulled into next/soc.
> 
> It's unclear to me whether we want this to be backported to stable 
> kernels,
> can you clarify?

It took me/us so much time to get an agreement on this patch I totally 
forgot
about backporting it to stable.

To be clear it indeed fixes a regression. Commit 937b12306ea79 ("ARM: 
BCM5301X:
remove workaround imprecise abort fault handler") went into 4.5, so this 
one
could be backported to 4.5+.

As this has been already pulled, I think I'll wait for it to appear in 
Linus's
tree and just e-mail stable guys manually (unless someone objects). 
Thanks for
bringing my attention to this.
