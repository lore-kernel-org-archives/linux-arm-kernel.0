From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Fri, 28 Sep 2012 19:01:04 +0530
Subject: [PATCH 1/6] usb: dwc3-omap: use of_platform API to create dwc3
 core pdev
In-Reply-To: <20120928125758.GK31006@arwen.pp.htv.fi>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-2-git-send-email-kishon@ti.com>
 <20120928125758.GK31006@arwen.pp.htv.fi>
Message-ID: <CAAe_U6JX8nqhZU-m+0Cfh1-xEkZhXNf2ecYcg_JX9mx5fv1b3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 28, 2012 at 6:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Sep 28, 2012 at 06:23:10PM +0530, Kishon Vijay Abraham I wrote:
>> Used of_platform_populate() to populate dwc3 core platform_device
>> from device tree data. Since now the allocation of unique device id is
>> handled be of_*, removed the call to dwc3_get_device_id.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> I think it's best if you split the use of device_for_each_child() from
> this patch. So first do the device_for_each_child() part, then later use
> of_platform_populate().

I think it's better to have it both together as of_platform_populate
will create the device and the device_for_each_child() part will
delete it on error conditions and during driver removal.
In this patch the first device_for_each_child() comes in error
condition and it is not needed if we have not created the device using
of_platform_populate.

Thanks
Kishon
