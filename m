From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 14:20:20 +0000
Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <55DC74CF.7070300@arm.com>
References: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
 <55DC677E.1030004@arm.com>
 <CY1PR0301MB0843D5CB5FFC56991B90EB4283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC74CF.7070300@arm.com>
Message-ID: <CY1PR0301MB084302FA2AA9582A3BA9B50B83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2015?8?25? 9:00
> To: Wang Shenwei-B38339
> Cc: Sudeep Holla; gregkh at linuxfoundation.org; arnd at arndb.de; Huang
> Yongcai-B20788; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module
> power gate
> > On latest Freescale i.MX7D, it has two SRAMs in side. One is for low
> > power mode which will be powered on in suspend state. The other one is
> > for other peripherals which can be powered off on demand.
> >
> 
> What I meant is who will be using the SRAM when entering S2R that you need to
> save the content. Either the user needs to take care of the content or just release
> the pool when not in use. When the sram pool has no user, clock can be gated.
> 
> Again can you give details of this use-case.

We are not talking about clock gate state. Here we are handling the power gate for 
this SRAM IP block. Of course, you can ask each driver to save its contents during 
low power state, but I think the easier way is to save the contents in this sram driver
and just leave the drivers who use this sram behave as is today.

Thanks,
Shenwei

> Regards,
> Sudeep
