From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu, 19 Oct 2017 19:20:51 +0200
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
In-Reply-To: <20171019170649.GG4394@atomide.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com>
 <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com>
 <20171019162416.GE4394@atomide.com>
 <152FA5B1-75F9-4F0B-9E05-6277CD83C975@goldelico.com>
 <20171019170649.GG4394@atomide.com>
Message-ID: <47187D0E-9D11-474F-972E-6192E3C35AC4@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Am 19.10.2017 um 19:06 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171019 09:57]:
>> Hi Tony,
>> 
>>> Am 19.10.2017 um 18:24 schrieb Tony Lindgren <tony@atomide.com>:
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [171018 08:49]:
>>>> 
>>>>> Am 18.10.2017 um 15:22 schrieb Tony Lindgren <tony@atomide.com>:
>>>>> 
>>>>> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
>>>>>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>>>>>>> 
>>>>>>> So I started something, it is at.
>>>>>>> 
>>>>>>> https://github.com/pavelmachek/libbattery
>>>>>>> 
>>>>>>> My battery on n900 is currently uncalibrated (and charging), still it
>>>>>>> gets some kind of estimation:
>>>>>>> 
>>>>>>> Battery -1 %
>>>>>>> Seconds -1
>>>>>>> State 1
>>>>>>> Voltage 3.88 V
>>>>>>> Battery 63 %
>>>>>>> 
>>>>>>> Of course, there's a lot more work to be done.
>>>>>> 
>>>>>> Nice start but not a solution to our problem.
>>>>>> 
>>>>>> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
>>>>>> displays the battery percentage.
>>>>> 
>>>>> I think we could make things compatible with various battery apps by
>>>>> having libbattery write back the capacity percentage and time remaining
>>>>> to the kernel driver via sysfs or a dev entry. Then the kernel interface
>>>>> can just display the data to whatever apps.
>>>> 
>>>> Hm. That would be quite difficult to understand and maintain code.
>>> 
>>> How so? The libbattery can do it all, then the kernel drivers needing
>>> that will just display the most recent values to maintain compability
>>> with battery apps.
>> 
>> Well, it looks as if you are thinking about a much more complex solution
>> than I am...
>> 
>> The proposal we are discussing as
>> 
>> [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
>> 
>> just reads the current voltage, charging current and uses a (nonlinear)
>> mapping to 0% .. 100%.
> 
> Right, I was discussing Pavel's libbattery link posted above. No
> comments on the current patch series.

Well, it was triggered by Sebastian's comment on this patch that 
some 10 years old Documentation recommends to write a libbattery.

And there is still some (weak) relation between the subject and libbattery.

> Let's move the libbattery stuff
> to a new thread to avoid confusion.

Agreed.

BR,
Nikolaus
