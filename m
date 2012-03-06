From: koen@dominion.thruhere.net (Koen Kooi)
Date: Tue, 6 Mar 2012 10:10:13 +0100
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
In-Reply-To: <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
 <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
Message-ID: <C67C8239-2E17-42E5-BEB4-2B7F623515B8@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 6 mrt. 2012, om 10:03 heeft Raja, Govindraj het volgende geschreven:

> On Mon, Mar 5, 2012 at 7:36 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>> 
>> Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:
>> 
>>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>> 
>>> On beagle some of uart mux lines are used for other
>>> purpose so init only uart3.
>>> 
>>> Uart2 rx line clashes with gpio_147 used for usb ehci
>>> phy reset. Initializing uart2 pad_mux lines can break
>>> ehci module on beagle xm.
>>> (gpio_147 is available on uart2_rx in mode4 reference
>>> mux34xx.c -> uart2_rx.gpio_147)
>> 
>> That's only on xM revision C, right?
> 
> Applicable to all beagle boards having external usb
> hub (USB2HS_nRST will require uart2_rx.gpio_147)

My apologies, I was confusing it with the DVI reset GPIO (which changed in between revisions) and the polarity of the USB pin (which changed during xM A -> C).

regards,

Koen
