From: swami.iyer@ti.com (Subbrathnam, Swaminathan)
Date: Fri, 27 Nov 2009 08:07:57 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <4B0ED746.1040201@ru.mvista.com>
References: <200908142241.00528.sshtylyov@ru.mvista.com>
	<4A8A202E.2040505@windriver.com> <4A8A7047.9080405@ru.mvista.com>
	<4A8CF552.3080801@windriver.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE36@dbde02.ent.ti.com>
	<4AE85B02.1080207@ru.mvista.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE60@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436EEB489@dbde02.ent.ti.com>
	<20091102103706.GB1133@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E73940436EEB5EF@dbde02.ent.ti.com>
	<20091102115458.GA3348@n2100.arm.linux.org.uk>,
	<4B0ED746.1040201@ru.mvista.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F97B1D14@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

Another option is to have the cppi-generic code reside in the musb directory itself.  We do not have other peripherals such as Ethernet using cppi4.1 infrastructure in the near future.  Given this I think it will be better to locate this code in the "drivers/usb/musb" directory itself and decide on any relocation later if the need arises (which I feel is remote).

regards
swami

________________________________________
From: Sergei Shtylyov [sshtylyov at ru.mvista.com]
Sent: Friday, November 27, 2009 1:00 AM
To: Russell King - ARM Linux
Cc: Gupta, Ajay Kumar; Hilman, Kevin; davinci-linux-open-source at linux.davincidsp.com; linux-usb at vger.kernel.org; david-b at pacbell.net; stanley.miao; Subbrathnam, Swaminathan; linux-arm-kernel at lists.infradead.org; dan.j.williams at intel.com; maciej.sosnowski at intel.com
Subject: Re: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)

Hello.

Russell King - ARM Linux wrote:

>>>>Is there any updated patch on cppi4.1 core also?

>>>Is there _any_ cppi4.1 core patch anywhere?  Not according to google.

>>Russell,

>>Here is the latest version of cppi4.1 core.
>>http://patchwork.kernel.org/patch/46698/

[...]

>>>If it's a USB DMA device (from the patches I can find, that seems to be
>>>the case) then why can't it live in drivers/usb or drivers/dma ?
>>
>>CPPI4.1 DMA engine can be used either by USB or by Ethernet interface though
>>currently only USB is using it but in future even Ethernet devices may use it.

> drivers/dma does seem to be the right place for this.

    Russell, it makes me wonder why drivers/dma/ seemed the right place to
you, just because of the name? :-)
    After spending some time on studying the infrastructure there I came to
conclusion that this is not the right place because all the controllers
supported there have features like memory-to-memory transfers or even RAID
function offloading -- which CPPI 4.1 totally lacks (it's there purely to
serve the peripherals).
    Adding drivers/dma/ people to this discussion in hopes they can correct
me (or support me :-)...

WBR, Sergei
