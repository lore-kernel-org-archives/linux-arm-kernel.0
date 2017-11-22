From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 21 Nov 2017 19:07:09 -0500
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <CAL_JsqLZgnTTEiLXD8ZOK-0qd58i16e7h_-2yjHN+zRFfqvH4Q@mail.gmail.com>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
 <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
 <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
 <f200ce55-ac67-02f9-4dbf-7a3ba5b52b39@codeaurora.org>
 <CAL_JsqLZgnTTEiLXD8ZOK-0qd58i16e7h_-2yjHN+zRFfqvH4Q@mail.gmail.com>
Message-ID: <32f8dc7e-9fde-5e45-1570-a9ec372579fa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2017 3:06 PM, Rob Herring wrote:

[..]

>> I like where you are going with this. Are you saying that I could read for a
>> device property read from firmware (for DTB or ACPI) like DWC3 does for
>> "snps,hird-threshold"?
> 
> Is that for the same thing? If so, drop the vendor prefix and use
> that. Otherwise, a separate property should really be something that
> is per board rather than per SoC.

I don't think that's exactly the same property, but it's the same idea I would
prefer to go with. That way, an integer can be passed in via the firmware tables.

> 
>> If you mean this, where do you recommend I store the
>> desired IRQ_CONTROL value - in struct xhci_hcd ?
> 
> No idea.
> 
>> Or by "compatible" strings, did you mean storing hard-coded values in the
>> of_device_id usb_xhci_of_match[] array? This would still be hard-coding (which I
>> would like to avoid) and also would not work for the ACPI case.
> 
> ACPI has match tables too?
> 

Yes, you can use DSD in a way that is similar to OF properties

> It would only be hardcoded per compatible which should be per SoC. Do
> you need per board/device tuning? If so, use a property.
> 

The reason why I think it should dynamic via firmware tables is that

* It's much less invasive for vendors to update their DT tables if they need to
adjust on a per device/controller/family/etc basis then to adjust a properties
table in xhci-plat
* This would lead to less polluting in xhci-plat code

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I will provide an updated proposed patch sometime this week. I also hope to get
some feedback from Mathias to see what he prefers.

Thanks again for the feedback Rob.


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
