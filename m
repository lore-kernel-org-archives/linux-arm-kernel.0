From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 27 Dec 2010 18:25:18 +0000
Subject: [PATCH] i.MX51: Full iomux support
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	<87y67rcdnf.fsf@lechat.rtp-net.org>	<19720.55896.197553.407321@ipc1.ka-ro>
	<87tyifcajm.fsf@lechat.rtp-net.org>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA067FCB@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>-----Original Message-----
>From: Nguyen Dinh-R00091
>Sent: Monday, December 27, 2010 11:47 AM
>To: 'Arnaud Patard'; Lothar Wa?mann
>Cc: Sascha Hauer; linux-arm-kernel at lists.infradead.org; Richard Zhao; Jason Wang
>Subject: RE: [PATCH] i.MX51: Full iomux support
>
>Hi,
>
>>-----Original Message-----
>>From: Arnaud Patard [mailto:arnaud.patard at rtp-net.org]
>>Sent: Wednesday, December 15, 2010 9:37 AM
>>To: Lothar Wa?mann
>>Cc: Sascha Hauer; linux-arm-kernel at lists.infradead.org; Richard Zhao; Nguyen Dinh-R00091; Jason Wang
>>Subject: Re: [PATCH] i.MX51: Full iomux support
>>
>>Lothar Wa?mann <LW@KARO-electronics.de> writes:
>>
>>> Hi,
>>>
>>> Arnaud Patard (Rtp) writes:
>>>> Sascha Hauer <s.hauer@pengutronix.de> writes:
>>> [...]
>>>> > The following series picks up the patch from Lothar Wa?mann replacing
>>>> > the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
>>>> > support based on this patch.
>>>> > The iomux configurations are taken from the Freescale pinmux tool, so the
>>>> > definitions should be rather complete. Anyway, there are some modes
>>>> > not present in the tool.
>>>> > I took the padmux settings from the old iomux support where present.
>>>>
>>>> I'm seeing a lot of changes in the iomux file and I have a patch [1]
>>>> setting the SION bit for all gpios configuration so that reading the PSR
>>>> value is giving usefull results when the gpio is configured as output. I
>>>> wanted to send it this week but it will obviously conflict with
>>>> this. Should I test your patchset first and if it's working, wait
>>>> for its merge or should I send it anyway ? How do you want to deal with
>>>> this (as long as you're fine with setting the SION bit for all gpios) ?
>>>>
>>> I had done the same, but had some trouble with this.
>>> E.g. on our board GPIO1_7 is used as a generic GPIO to enable an
>>> external clock oscillator for the USBH1 ULPI PHY. When the SION bit
>>> for this pad was set, I got strange errors on the USBH1 port
>>> (disconnecting low speed devices behind a hub would stall the
>>> bus). When I removed the SION bit for that pin everything worked
>>> well.
>>
>>wow. Would be nice to have feedback from fsl. I was fearing of bad
>>effects but I didn't think they could actually break something so
>>badly. After all, the manual doesn't warn about possible side effects of
>>the SION bit iirc. This would mean this will have to be dealt on a board
>>basis. It would be... erm... not really "efficient".
>>
>>Arnaud
>
>You cannot blindly set the SION bit for all GPIO's. I have to dig through my email history for a more
>technical explanation.
>
>Thanks,
>Dinh

The SION bit is a "Software Input On" bit. Basically, if you set the GPIO as an output, you cannot set the SION bit.

Dinh
