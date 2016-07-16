From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jul 2016 21:09:33 -0400
Subject: [PATCH V9 6/9] vfio: platform: call _RST method when using ACPI
In-Reply-To: <20160714160439.5bafca73@t450s.home>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-7-git-send-email-okaya@codeaurora.org>
 <20160714160439.5bafca73@t450s.home>
Message-ID: <b46984d2-25b4-9d3b-394b-b0baf92bbf01@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/14/2016 6:04 PM, Alex Williamson wrote:
>> +static inline
>> > +bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
>> > +{
>> > +#ifdef CONFIG_ACPI
>> > +	struct device *dev = vdev->device;
>> > +	acpi_handle handle = ACPI_HANDLE(dev);
>> > +
>> > +	return acpi_has_method(handle, "_RST");
>> > +#else
>> > +	return false;
>> > +#endif
>> > +}
> What exactly is the rationale for making these inline?  Clearly reset
> is not a performance relevant path.  Thanks,
> 
> Alex
> 

It is remaining from the previous stub functions which were inline. I'll get rid
of the inlines.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
