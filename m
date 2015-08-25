From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 25 Aug 2015 15:05:36 +0000
Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <55DC7E5E.5020701@arm.com>
References: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
 <55DC677E.1030004@arm.com>
 <CY1PR0301MB0843D5CB5FFC56991B90EB4283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC74CF.7070300@arm.com>
 <CY1PR0301MB084302FA2AA9582A3BA9B50B83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC7E5E.5020701@arm.com>
Message-ID: <CY1PR0301MB0843A508122C7FCF3969AF3D83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2015?8?25? 9:41
> To: Wang Shenwei-B38339
> Cc: Sudeep Holla; gregkh at linuxfoundation.org; arnd at arndb.de; Huang
> Yongcai-B20788; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module
> power gate
> >> What I meant is who will be using the SRAM when entering S2R that you
> >> need to save the content. Either the user needs to take care of the
> >> content or just release the pool when not in use. When the sram pool has no
> user, clock can be gated.
> >>
> >> Again can you give details of this use-case.
> >
> > We are not talking about clock gate state. Here we are handling the
> > power gate for this SRAM IP block. Of course, you can ask each driver
> > to save its contents during low power state, but I think the easier
> > way is to save the contents in this sram driver and just leave the drivers who
> use this sram behave as is today.
> >
> 
> I don't like that solution as it's not scalable with SRAM size and saving all the
> content of SRAM just because of few active regions makes no sense to me
> at-least. I prefer leaving it to the users to handle that rather than SRAM driver.

I don't think it is not scalable. The choice should be made by the application.
>From the driver side, it should be able to provide the way to retain its contents
during power gate. 

Regards,
Shenwei

> Regards,
> Sudeep
