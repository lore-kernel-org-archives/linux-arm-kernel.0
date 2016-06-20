From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jun 2016 22:56:59 +0200
Subject: [PATCH 0/1] ARM: dts: sunxi: Fix simplefb not working in 4.7-rc1
In-Reply-To: <20160620074610.GH26668@lukather>
References: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
 <20160609074643.GA5242@lukather>
 <21258fc0-0250-951b-2ee7-d022fb3c09ac@redhat.com>
 <20160613080124.GA4481@lukather>
 <1a9a0d76-5bbf-4b79-abee-1c9dd0436567@redhat.com>
 <20160620074610.GH26668@lukather>
Message-ID: <d239fb49-61a1-a574-8fa8-205b6a51a595@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-06-16 09:46, Maxime Ripard wrote:
> On Mon, Jun 13, 2016 at 10:30:57AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 13-06-16 10:01, Maxime Ripard wrote:
>>> On Thu, Jun 09, 2016 at 12:47:36PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 09-06-16 09:46, Maxime Ripard wrote:
>>>>> Hi Hans,
>>>>>
>>>>> On Sat, Jun 04, 2016 at 08:05:23PM +0200, Hans de Goede wrote:
>>>>>> Hi Maxime,
>>>>>>
>>>>>> While testing 4.7-rc1 / linux-sunxi/sunxi-next on a A10s I noticed that
>>>>>> hdmi out is no longer working (screen goes black when the kernel turns
>>>>>> of unused clocks).
>>>>>>
>>>>>> This is caused by the dtsi for sun4i / sun5i / sun7i based boards now
>>>>>> listing pll3, without pll3 being added to the clocks list for the
>>>>>> simplefb nodes.
>>>>>
>>>>> Why not do just that then? It's more appropriate for a fix imho.
>>>>
>>>> You mean just for sun5i-a10s, or for all of sun4i / sun5i-a10s and
>>>> sun7i ?
>>>>
>>>> For sun4i and sun7i things are already fixed in next:
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=5a7f2310cc847a73852e70bc720a61ca9bf986a6
>>>> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=c79255ca4d7b67cce4eac4dd532e097ce49f3679
>>>>
>>>> It seems best to use those fixes, rather then come up with a separate
>>>> fix for 4.7.
>>>>
>>>> My patch for fixing sun5i-a10s is inline with the 2 above patches,
>>>> which seems best, rather then doing something special for just sun5i-a10s.
>>>
>>> Well, you are doing something special for just the A10s: the patches
>>> quoted above just add a bunch of clocks and add the handles to the
>>> list of clocks managed by simplefb.
>>>
>>> For the A10s, you also declare the whole display engine block without
>>> anyone having tested that it was actually working.
>>
>> A10s is the same SoC as A13 / R8, just in a different package / with
>> different pins routed to the outside and it features a parallel LCD
>> interface just like the A13 / R8. We've had this confirmed by
>> Allwinner multiple times now, A13 / A10s / R8 literary are the same
>> chip, there simply is no way the displayblock on the A10s somehow
>> is magically different.
>>
>> Given all this, clearly having this identical displayblock in the
>> shared sun5i.dtsi is the right thing to do.
>
> Maybe, but this is not a patch for an 4.7-rc* release, but for the
> next merge window.

Ok, I'll send out a patch with the simple fix for 4.7 for sun4i / sun5i-a10s / sun7i
then.

Regards,

Hans
