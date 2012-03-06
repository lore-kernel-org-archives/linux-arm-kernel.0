From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Tue, 6 Mar 2012 14:33:16 +0530
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
In-Reply-To: <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
Message-ID: <CAMrsUdJfSeu8W+gS+HfDKw5WFXvaVK2TzXhqhr6tdRhujU18uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2012 at 7:36 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>
> Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> On beagle some of uart mux lines are used for other
>> purpose so init only uart3.
>>
>> Uart2 rx line clashes with gpio_147 used for usb ehci
>> phy reset. Initializing uart2 pad_mux lines can break
>> ehci module on beagle xm.
>> (gpio_147 is available on uart2_rx in mode4 reference
>> mux34xx.c -> uart2_rx.gpio_147)
>
> That's only on xM revision C, right?

Applicable to all beagle boards having external usb
hub (USB2HS_nRST will require uart2_rx.gpio_147)

Beagle Rev Ax/Bx doesn't seem to have external hub
module so not applicable for those boards

Will modify and post a new patch.

--
Thanks,
Govindraj.R
