From: sr@denx.de (Stefan Roese)
Date: Thu, 25 Jun 2015 12:33:57 +0200
Subject: mvebu: Problem booting Armada XP with mainline U-Boot
In-Reply-To: <20150624192401.650b0206@free-electrons.com>
References: <558A9EBA.9000902@denx.de>
 <20150624192401.650b0206@free-electrons.com>
Message-ID: <558BD915.4090000@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24.06.2015 19:24, Thomas Petazzoni wrote:

<snip>

>> b) Booting hangs completely while/after loading some device drivers:
>>
>> ...
>> [    4.031651] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    4.038209] ehci-pci: EHCI PCI platform driver
>> [    4.042694] ehci-orion: EHCI orion driver
>> [    4.046784] orion-ehci f1050000.usb: EHCI Host Controller
>> [    4.052207] orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
>> [    4.059851] orion-ehci f1050000.usb: irq 27, io mem 0xf1050000
>
> Maybe missing USB PHY initialization or SERDES lanes initialization.
> These are done by the binary header, so I guess they are missing in the
> mainline U-Boot.

This SERDES / PHY initialization code from the Marvell bin_hdr is 
already integrated in mainline U-Boot SPL. So this is most likely not 
the root cause for this hangup.

> We are hoping to work on such topics in the kernel in
> the near future, though, so that the kernel is taking of PHY and SERDES
> lanes initialization, and can also power them up/down for power
> management needs.

Good to know. Thanks.

>> Any ideas why those problems might occur with mainline U-Boot?
>> Most likely some register setup is missing that is usually done
>> in bin_hdr. Where could I check / test for this CPU online
>> problem?
>
> Hard to say, probably the easiest is to read the binary header code to
> see what they are doing.

I thought that somebody might have a quick idea about something obvious 
going wrong here. If this is not the case, then I'll dig into the 
bin_hdr code again...

Thanks,
Stefan
