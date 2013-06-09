From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun, 09 Jun 2013 11:05:14 -0700
Subject: pxa27x and pinctrl-single
In-Reply-To: <CAD6h2NSewh=uodiRGNOVHTiJqMrYg25hMW56rUSPPviTTb_9Ng@mail.gmail.com>
References: <51AF7404.3090003@newsguy.com>
 <CAD6h2NTu9-E=Xy8zz5cgDdk5W4ShM9-B+p+gQtiA_HASQ7AEuQ@mail.gmail.com>
 <51B0C7E8.5090308@newsguy.com>
 <CAD6h2NSRCti57NZtw0wzE8Th65_3Y8Dkz5zGsbnA2SUPYS263Q@mail.gmail.com>
 <51B12DE9.9040908@newsguy.com>
 <CAN1soZyOzrRewwx0up2s+4igUf77h+UbFpCsm324O-nkBWcsTQ@mail.gmail.com>
 <51B1F330.9080007@newsguy.com>
 <CAD6h2NStRcXm_X=0ib=RtKqVhmsfGo4z=_jzL1hUo_MLcfyBZw@mail.gmail.com>
 <51B21B3B.8050604@newsguy.com>
 <CAD6h2NSewh=uodiRGNOVHTiJqMrYg25hMW56rUSPPviTTb_9Ng@mail.gmail.com>
Message-ID: <51B4C3DA.2000403@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 06:20 PM, Haojian Zhuang wrote:
> On 8 June 2013 01:41, Mike Dunn <mikedunn@newsguy.com> wrote:
>> On 06/07/2013 08:16 AM, Haojian Zhuang wrote:
>>>
>>
>> [...]
>>
>>
>>> Since you need to configure both GPDRx and GAFRx. If we are talking
>>> pinctrl-single
>>> as reference, we can make it work by this way.
>>>
>>> We need to define two pinmux controllers. One is for GPDRx, and the
>>> other is for GAFRx.
>>> Both of them need to support pinctrl-single,bits property. For any
>>> alternate pins in DTS,
>>> we could include these two pins from two pinmux controllers. What's
>>> your opinion?
>>
>>
>> Are you are suggesting that the dts file can be defined such that the desired
>> values are written to GAFR and GPDR, without having to make any changes to the
>> pinctrl-single driver code?  If I understand correctly, we would be defining two
>> "pins" in the device tree for each actual pin.  That seems very ugly.
>>
>> I was thinking that pinctrl-single could be modified to support multiple
>> reg/value/mask pairs for each pin listed in the pinctrl-single,bits property.
>> There is a comment at the top of pcs_parse_one_pinctrl_entry() that seems to
>> suggest the possibility...
> 
> We only support continuous register offset in pinctrl-single driver.
> GPDRx is in range of 0x40e0000c~0x40e0010c, GAFRx is in range of
> 0x40e00054~0x40e00070.


Ah, I see...


> 
> So I suggest you to split them as two pinmux controller. If you define them into
> one pinmux controler, it's also OK. But they are still two pins in the on pinmux
> controller. And you should avoid to access those spare pins in the middle.


I'm still not smart enough to parse this.  Do you mean create a separate driver,
or two instances of pinctrl-single?


> 
> I don't suggest you to support multiple reg/value/mask pairs for each pin in
> pinctrl-single driver. It's too complex. It already exceeds the design scope
> of the pinctrl-single driver.


Yes, this I understand.  BTW, I see there are more patches for pinctrl-single
coming in.

Thanks for the advice Haojian.

Mike
