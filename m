From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Mon, 2 Nov 2009 16:27:59 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <20091102103706.GB1133@n2100.arm.linux.org.uk>
References: <200908142241.00528.sshtylyov@ru.mvista.com>
	<4A8A202E.2040505@windriver.com> <4A8A7047.9080405@ru.mvista.com>
	<4A8CF552.3080801@windriver.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE36@dbde02.ent.ti.com>
	<4AE85B02.1080207@ru.mvista.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE60@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436EEB489@dbde02.ent.ti.com>
	<20091102103706.GB1133@n2100.arm.linux.org.uk>
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEB5EF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Nov 02, 2009 at 09:51:13AM +0530, Gupta, Ajay Kumar wrote:
> > Is there any updated patch on cppi4.1 core also?
> 
> Is there _any_ cppi4.1 core patch anywhere?  Not according to google.

Russell,

Here is the latest version of cppi4.1 core.
http://patchwork.kernel.org/patch/46698/

 
> > Another option is to create arch/arm/ti-common to place all TI
> platform's
> > common software, such as CPPI4.1 used both in DA8xx and AM3517.
> 
> No thanks.  I really don't see why we should allow TI to have yet more
> directories scattered throughout the tree that are out of place with
> existing conventions.
> 
> And what is this CPPI thing anyway?
> 
> http://acronyms.thefreedictionary.com/CPPI
> 
> "Communications Port Programming Interface" seems to be about the best
> applicable one from that list!

Yes, this is the correct one.

> If it's a USB DMA device (from the patches I can find, that seems to be
> the case) then why can't it live in drivers/usb or drivers/dma ?

CPPI4.1 DMA engine can be used either by USB or by Ethernet interface though
currently only USB is using it but in future even Ethernet devices may use it.

Infact, there is a TI platform (not in mainline), where both USB and Ethernet interface is using CPPI4.1 DMA.

Regards,
Ajay
