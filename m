From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Wed, 4 Oct 2017 20:50:03 +0200
Subject: [PATCH 3/5] firmware: arm_scpi: pre-populate dvfs info in
 scpi_probe
In-Reply-To: <6ece57aa-81e0-c984-5eac-a0b54aa0d625@arm.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <c8c0ff86-de14-f157-68e0-9df005defffa@gmail.com>
 <d6578a58-b7ab-9770-d78d-1971d1e702d4@arm.com>
 <db4476f4-df96-6ce5-ca5f-95141364fa62@gmail.com>
 <0e5959a7-6826-1909-1509-f6627a9688ed@arm.com>
 <ffb9c571-edd3-7ea0-ecf6-f72c2ddd9fc1@gmail.com>
 <e34ca682-aa86-4057-cf29-172ff5764d07@arm.com>
 <106745da-1027-5760-de51-7a74c033964b@gmail.com>
 <6ece57aa-81e0-c984-5eac-a0b54aa0d625@arm.com>
Message-ID: <486a06bc-6bb8-d8e8-29b3-bd959afd2326@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.10.2017 um 12:10 schrieb Sudeep Holla:
> 
> 
> On 03/10/17 19:19, Heiner Kallweit wrote:
>> Am 03.10.2017 um 18:18 schrieb Sudeep Holla:
>>>
>>>
>>> On 03/10/17 17:00, Heiner Kallweit wrote:
> 
> [...]
> 
>>>>>>
>>>>>> Remove does for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
>>>>>> and therefore stops at the first unpopulated domain and doesn't free
>>>>>> the memory for further populated domains. I'll provide a patch for
>>>>>> it.
>>>>>>
>>>>>
>>>>> Does that mean you are re-introducing scpi_remove ? I kind of liked
>>>>> removing it.
>>>>>
>>>> Sorry for the confusion. Then I'll go with the original approach and
>>>> just make sure that errors whilst populating dvfs info are ignored.
>>>>
>>>
>>> Indeed.
>>>
>>> If you are fine with the below fixup, then I can add it myself. Let me know.
>>>
>> Fine with me.
> 
> Thanks for confirming, pushed now[1]. Can you please double check if
> possible.
> 
Compiles and works fine here.
By the way, I have three more small patches which I think are improvements (YMMV).
Will submit them later today.
