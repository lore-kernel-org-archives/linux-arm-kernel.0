From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 14 Aug 2017 11:04:47 -0700
Subject: [PATCH v2 16/18] hwmon: add support for sensors exported via ARM
 SCMI
In-Reply-To: <c695dc09-fc28-518f-f287-bf74e0a2f87e@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-17-git-send-email-sudeep.holla@arm.com>
 <20170804193231.GA18153@roeck-us.net>
 <20e0a388-79a1-a7f1-57b4-fa5993eed9bf@arm.com>
 <c695dc09-fc28-518f-f287-bf74e0a2f87e@arm.com>
Message-ID: <20170814180447.GA9577@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 04:09:18PM +0100, Sudeep Holla wrote:
> Hi Guenter,
> 
> On 07/08/17 13:25, Sudeep Holla wrote:
> > 
> > 
> > On 04/08/17 20:32, Guenter Roeck wrote:
> >> On Fri, Aug 04, 2017 at 03:31:42PM +0100, Sudeep Holla wrote:
> > 
> > [...]
> > 
> >>> +	platform_set_drvdata(pdev, scmi_sensors);
> >>> +
> >>> +	hwdev = devm_hwmon_device_register_with_groups(dev, "scmi_sensors",
> >>> +						       scmi_sensors,
> >>> +						       scmi_sensors->groups);
> >>
> >> Can you rework this to use devm_hwmon_device_register_with_info(),
> >> and if possible let it handle the thermal registration ? 
> >>
> > 
> > Thanks for the pointers. I will check on the possibility and use it if
> > possible.
> > 
> 
> I had a look at devm_hwmon_device_register_with_info. It mostly deals
> with constant structures where all the attributes are known at the boot
> time. In case of SCMI, the firmware presents all the sensors and all the
> information(type, scale, name/label, ...etc). Unless I create those
> structures dynamically and typecast as const during probe, I can't get
> it working. Are you OK with that ? If so, I can try making those changes.
> 

Yes, please.

What operations exactly fail, though ? The idea was that the structures
are not modified by the infrastructure code, not that they must be constant
in the driver. Maybe some of the structure definitions are simply wrong. 

Thanks,
Guenter
