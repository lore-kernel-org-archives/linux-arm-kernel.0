From: fkan@apm.com (Feng Kan)
Date: Tue, 18 Nov 2014 12:05:17 -0800
Subject: [PATCH v2 2/2] [usb] add support for ACPI identification to
 xhci-platform
In-Reply-To: <5464FA19.6030609@redhat.com>
References: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-1-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-2-git-send-email-mlangsdo@redhat.com>
 <20141104171220.GA30385@kroah.com> <5464FA19.6030609@redhat.com>
Message-ID: <CAL85gmDr14EHK+7-ojx5vxvc0ykUsTGxku4LWS=w8TFEh3Bw9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:36 AM, Mark Langsdorf <mlangsdo@redhat.com> wrote:
> On 11/04/2014 11:12 AM, Greg KH wrote:
>>
>> On Tue, Nov 04, 2014 at 10:50:33AM -0600, Mark Langsdorf wrote:
>
>   #endif
>>>
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id usb_xhci_acpi_match[] = {
>>> +       /* APM X-Gene USB Controller */
>>> +       { "PNP0D10", },

Mark, would it be better to use PRP0001 instead as in this patch?
https://lkml.org/lkml/2014/9/16/230

>>> +       { }
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
>>> +#endif
>>
>>
>> That looks like a very "generic" PNP value, are you sure it is assigned
>> only to this specific device?
>
>
> Although this is a generic PNP device, the specific implementation
> I'm testing has issues with USB3. Is there a flag or function
> call that will disable the USB3 host while keeping the USB2
> host?? My naive attempts in finding one mostly hung the machine.
>
> --Mark Langsdorf
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
