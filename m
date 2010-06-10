From: saeed@marvell.com (Saeed Bishara)
Date: Thu, 10 Jun 2010 13:57:16 +0300
Subject: [PATCH] [kirkwood-otg] Leverage the Freescale OTG driver for
	Kirkwood OTG
In-Reply-To: <AANLkTikVeVBdSfeS_p0k4dRwFopELw2OIXUrS1NjEdt6@mail.gmail.com>
References: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
	<1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
	<alpine.LFD.2.00.1006091307321.30664@xanadu.home>
	<AANLkTikVeVBdSfeS_p0k4dRwFopELw2OIXUrS1NjEdt6@mail.gmail.com>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009F9FAC75ABB8@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Jason McMullan [mailto:jason.mcmullan at netronome.com] 
>Sent: Wednesday, June 09, 2010 9:07 PM
>To: Nicolas Pitre
>Cc: linux-arm-kernel at lists.infradead.org; Haavard Skinnemoen; 
>Ronen Shitrit; Saeed Bishara; Rabeeh Khoury; Guennadi 
>Liakhovetski; Li Yang; Lennert Buytenhek
>Subject: Re: [PATCH] [kirkwood-otg] Leverage the Freescale OTG 
>driver for Kirkwood OTG
>
>On Wed, Jun 9, 2010 at 1:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Wed, 9 Jun 2010, Jason S. McMullan wrote:
>>> NOTE: Your bootloader must ensure that the Kirkwood
>>> ? ? ? USB 2.0 Bridge Window registers are set correctly,
>>> ? ? ? or the driver will stall on the first DMA.
>>
>> Could you add the code to sets that up in the kernel instead?
>
>Will do.
>
>>> ?config USB_GADGET_FSL_USB2
>>
>> Maybe the help text should be extended to mention Kirkwood?
>
>Again, good idea, will do.
Jason, the USB on kirkwood (and all orions) doesn't support OTG feature, it only support device mode when the system configured for that mode, so please repace the "otg" with udc.
Saeed
