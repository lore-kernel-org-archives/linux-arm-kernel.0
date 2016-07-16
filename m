From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jul 2016 21:07:23 -0400
Subject: [PATCH V9 7/9] vfio, platform: make reset driver a requirement by
 default
In-Reply-To: <20160714162454.4b05813c@t450s.home>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-8-git-send-email-okaya@codeaurora.org>
 <20160714162454.4b05813c@t450s.home>
Message-ID: <46aea353-ced9-bd6b-199f-9a785d1d8758@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/14/2016 6:24 PM, Alex Williamson wrote:
>> struct vfio_platform_device {
>> > +	bool				reset_required;
>> >  	struct vfio_platform_region	*regions;
>> >  	u32				num_regions;
>> >  	struct vfio_platform_irq	*irqs;
> Either you have 64bit bools or you're not paying any attention to
> to the alignment of this structure.  If we only care about 64bit
> systems we could tuck this into the gap after num_regions, otherwise
> append it to the end of the structure, we certainly don't care about
> keeping a reset flag within cache line boundaries.  Thanks,

OK, I moved it to the end of the structure.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
