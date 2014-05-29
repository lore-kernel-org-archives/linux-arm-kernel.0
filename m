From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 08:47:31 -0500
Subject: [PATCH v3 1/5] sc_phy:SmartCard(SC) PHY interface to SC controller
In-Reply-To: <5386F0FE.7040003@ti.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-2-git-send-email-satish.patel@ti.com>
 <20140528185334.GA30763@kroah.com> <5386F0FE.7040003@ti.com>
Message-ID: <CAL_Jsq+E7a=wh_yzQyaSEVAwfa34BYZ4DxvLOfJGFVDsf1dZ+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 3:34 AM, Satish Patel <satish.patel@ti.com> wrote:
>
>
> On 5/29/2014 12:23 AM, Greg KH wrote:
>>
>> On Wed, May 28, 2014 at 02:27:13PM +0530, Satish Patel wrote:
>>>
>>> SmartCard controller uses this interface to communicate with
>>> SmartCard via PHY
>>>
>>> Some SmartCard PHY has multiple slots for cards.
>>> This inerface also enables controller to communicate
>>> with one or more SmartCard connected over phy.
>>>
>>> interface structure includes following APIs
>>> - set/get config
>>> - activate/deactivate smart card
>>> - warm reset
>>> - register_notify (for card insert/remove/overheat)
>>> - unregister_notify
>>>
>>> Signed-off-by: Satish Patel <satish.patel@ti.com>
>>> ---
>>>   Documentation/sc_phy.txt |  171
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/sc_phy.h   |  136 ++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 307 insertions(+)
>>>   create mode 100644 Documentation/sc_phy.txt
>>>   create mode 100644 include/linux/sc_phy.h
>>
>>
>> These are .h files, but where is the "api" functions that use
>> these structures defined at?
>>
> This is like template/wrappers, smart card phy driver will write API
> functions. And smartcard controller will call these functions.
> With proposed approach, smartcard controller can communicate with any smart
> card phy (TI/NxP) without change in code. Using DT entry smartcard and PHY
> will gets connected with each other.
> Refer diagram given @Documentation/sc_phy.txt.
>
>
>> confused,

I believe the api Greg is wondering about is the notifier which as I
commented is not a good design.

There is now a phy subsystem. I don't know if it has what you need,
but you should look at it to determine if it will work or could be
extended to work.

Rob
