From: fkan@apm.com (Feng Kan)
Date: Tue, 18 Nov 2014 13:11:47 -0800
Subject: [PATCH v2 2/2] [usb] add support for ACPI identification to
 xhci-platform
In-Reply-To: <546BAD34.8040206@redhat.com>
References: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-1-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-2-git-send-email-mlangsdo@redhat.com>
 <20141104171220.GA30385@kroah.com> <5464FA19.6030609@redhat.com>
 <CAL85gmDr14EHK+7-ojx5vxvc0ykUsTGxku4LWS=w8TFEh3Bw9w@mail.gmail.com>
 <546BAD34.8040206@redhat.com>
Message-ID: <CAL85gmAx366bsUa2LQihXQ921LKL6RDTrAai7iFMwo48OShLYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 12:33 PM, Mark Langsdorf <mlangsdo@redhat.com> wrote:
> On 11/18/2014 02:05 PM, Feng Kan wrote:
>>
>> On Thu, Nov 13, 2014 at 10:36 AM, Mark Langsdorf <mlangsdo@redhat.com>
>> wrote:
>>>
>>> On 11/04/2014 11:12 AM, Greg KH wrote:
>>>>
>>>>
>>>> On Tue, Nov 04, 2014 at 10:50:33AM -0600, Mark Langsdorf wrote:
>>>
>>>
>>>    #endif
>>>>>
>>>>>
>>>>>
>>>>> +#ifdef CONFIG_ACPI
>>>>> +static const struct acpi_device_id usb_xhci_acpi_match[] = {
>>>>> +       /* APM X-Gene USB Controller */
>>>>> +       { "PNP0D10", },
>>
>>
>> Mark, would it be better to use PRP0001 instead as in this patch?
>> https://lkml.org/lkml/2014/9/16/230
>
>
> Quoting Arnd,
>
> "In this case, the device does have an official ACPI ID "PNP0D10",
> so we should use that for compatibility with other operating
> systems and with BIOS versions that provide the standard IDs."
>
Yes, thanks. I missed that part, sorry for the spam then.
> --Mark Langsdorf
