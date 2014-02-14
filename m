From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Fri, 14 Feb 2014 13:55:05 +0100
Subject: imx6: usbhc2/3 and HSIC
In-Reply-To: <CAH9NwWf8rc+PJygNP45x669nyiPqirF_PHOXGEQ_CX7PWaB7pQ@mail.gmail.com>
References: <CAH9NwWckD5Rmr9oW2Gr071V2p0FjRJcttYpB4qQNEWTxDEJ6qw@mail.gmail.com>
 <1390815772.4847.9.camel@weser.hi.pengutronix.de>
 <CAH9NwWf8rc+PJygNP45x669nyiPqirF_PHOXGEQ_CX7PWaB7pQ@mail.gmail.com>
Message-ID: <CAH9NwWcMQDH+NrSaRxLkj12NtDtuNFzQcBXNmjm4F__z5YewYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-01-27 17:42 GMT+01:00 Christian Gmeiner <christian.gmeiner@gmail.com>:
> Hi Lucas
>
> 2014-01-27 Lucas Stach <l.stach@pengutronix.de>:
>> Hi Christian,
>>
>> Am Montag, den 27.01.2014, 10:22 +0100 schrieb Christian Gmeiner:
>>> Hi all...
>>>
>>> does anyone used the usbhc2 or usbhc3 in HSIC mode? I am trying my
>>> luck but I do not
>>> get it to work. Is there anything special I need to take care of?
>>>
>> I remember we had this working on a board back in the 3.10 days. The
>> only thing I remember which is specific to HSIC is in the attached
>> patch. This isn't really clean and should be done in a better way for
>> mainline, but maybe it provides some pointers for you.
>>
>
> Thanks for the small patch... I got it almost working - the HSIC
> device seems to have some problems.
> I hope to find some time soon to get this stuff into mainline.
>

It does not work :(

Here are some logs: http://dpaste.com/hold/1617947/
It looks like EHCI takes over and does one port (the HSIC?). The problem
seems now that the port never changes its status to connected, but I am
100% sure that there is a LAN9730 [1] connected to that usbhc.

[1] http://www.microchip.com/wwwproducts/Devices.aspx?product=LAN9730

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
