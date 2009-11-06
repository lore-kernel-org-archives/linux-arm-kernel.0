From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Fri, 6 Nov 2009 09:15:56 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEBA17@dbde02.ent.ti.com>
References: <200908142241.00528.sshtylyov@ru.mvista.com>
	<4A8A202E.2040505@windriver.com> <4A8A7047.9080405@ru.mvista.com>
	<4A8CF552.3080801@windriver.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE36@dbde02.ent.ti.com>
	<4AE85B02.1080207@ru.mvista.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE60@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436EEB489@dbde02.ent.ti.com>
	<20091102103706.GB1133@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E73940436EEB5EF@dbde02.ent.ti.com>
	<20091102115458.GA3348@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E73940436EEBA17@dbde02.ent.ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E73940436F93AE6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 3. linking_ram - cppi41_queue_mgr_init() seems to be the only user.  I
> >    don't see why linking_ram would be necessary.
> >
> > 4. debugging printks via pr_debug() please (and define DEBUG at the top
> of
> >    the file to enable debugging.)
> 
> Thanks for the review and valuable comments.
> 
> As we have to change the current implementation in accordance with
> standard DMA APIs, we will take above comments and post it in next RFC.

Sergei,

Any comment on this?  

Regards,
Ajay

> > > > If it's a USB DMA device (from the patches I can find, that seems to
> > be
> > > > the case) then why can't it live in drivers/usb or drivers/dma ?
> > >
> > > CPPI4.1 DMA engine can be used either by USB or by Ethernet interface
> > though
> > > currently only USB is using it but in future even Ethernet devices may
> > use it.
> >
> > drivers/dma does seem to be the right place for this.
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
