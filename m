From: lho@apm.com (Loc Ho)
Date: Thu, 27 Feb 2014 13:09:57 -0800
Subject: [PATCH v12 1/4] PHY: Add function set_speed to generic PHY
 framework
In-Reply-To: <20140227205039.GE5375@saruman.home>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <20140227190102.GB4862@saruman.home>
 <CAPw-ZT=F07=T0=z=iT=hxJ0+609RBDYRL=MXF5dQoEowLjsRjQ@mail.gmail.com>
 <20140227205039.GE5375@saruman.home>
Message-ID: <CAPw-ZT=7cu1NoxrBL48RUJV04ofrnNkF=p=23VFfu8ZZWmkQWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> >> This patch adds function set_speed to the generic PHY framework operation
>> >> structure. This function can be called to instruct the PHY underlying layer
>> >> at specified lane to configure for specified speed in hertz.
>> >
>> > why ? looks like clk_set_rate() is your friend here. Can you be more
>> > descriptive of the use case ? When will this be used ?
>> >
>>
>> The phy_set_speed is used to configure the operation speed of the PHY
>> at run-time. The clock interface in general is used to configure the
>> clock input to the IP. I don't believe they are the same thing. Maybe
>> it will be clear in my response to your second email
>
> The problem with this is that you end up adding SATA-specific details to
> something which is supposed to be generic.

Setting the operation speed is pretty generic from an interface point
of view. An generic multi-purpose PHY can support multiple speed. If
the upper layer wish to operate at an specified speed (say for testing
purpose and etc), it can be allowed.

> After negoatiation, don't you
> get any interrupt from your PHY indicating that link speed negotiation
> is done ? Or is that IRQ only on AHCI IP ?

There is NO interrupt from the PHY. The IRQ is assoicated with the
AHCI IP. With SATA host flow, it starts off with an COMRESET to start
the link negotiation. At that point, it will poll for completion.

Any other concerns?

-Loc
