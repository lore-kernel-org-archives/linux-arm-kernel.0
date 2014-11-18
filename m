From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Tue, 18 Nov 2014 14:33:56 -0600
Subject: [PATCH v2 2/2] [usb] add support for ACPI identification to
 xhci-platform
In-Reply-To: <CAL85gmDr14EHK+7-ojx5vxvc0ykUsTGxku4LWS=w8TFEh3Bw9w@mail.gmail.com>
References: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>	<1415119833-9135-1-git-send-email-mlangsdo@redhat.com>	<1415119833-9135-2-git-send-email-mlangsdo@redhat.com>	<20141104171220.GA30385@kroah.com>	<5464FA19.6030609@redhat.com>
 <CAL85gmDr14EHK+7-ojx5vxvc0ykUsTGxku4LWS=w8TFEh3Bw9w@mail.gmail.com>
Message-ID: <546BAD34.8040206@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 02:05 PM, Feng Kan wrote:
> On Thu, Nov 13, 2014 at 10:36 AM, Mark Langsdorf <mlangsdo@redhat.com> wrote:
>> On 11/04/2014 11:12 AM, Greg KH wrote:
>>>
>>> On Tue, Nov 04, 2014 at 10:50:33AM -0600, Mark Langsdorf wrote:
>>
>>    #endif
>>>>
>>>>
>>>> +#ifdef CONFIG_ACPI
>>>> +static const struct acpi_device_id usb_xhci_acpi_match[] = {
>>>> +       /* APM X-Gene USB Controller */
>>>> +       { "PNP0D10", },
>
> Mark, would it be better to use PRP0001 instead as in this patch?
> https://lkml.org/lkml/2014/9/16/230

Quoting Arnd,
"In this case, the device does have an official ACPI ID "PNP0D10",
so we should use that for compatibility with other operating
systems and with BIOS versions that provide the standard IDs."

--Mark Langsdorf
