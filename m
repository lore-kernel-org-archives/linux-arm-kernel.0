From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Mon, 4 Jul 2016 10:41:20 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm, nvram_file_name
 dt property
In-Reply-To: <7975990.MvNRQ06u39@wuerfel>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <CAOiHx=m8Zf0T4=BTG6BMRjj3kOHzt4YaQa3yzutmrhFSOyZMmA@mail.gmail.com>
 <ced2a770-2724-bdc9-7e2a-3dc9f76abf29@broadcom.com>
 <7975990.MvNRQ06u39@wuerfel>
Message-ID: <ac480a61-5bfd-5d0c-26fe-b85220ee5076@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2-7-2016 23:30, Arnd Bergmann wrote:
> On Saturday, July 2, 2016 8:20:35 PM CEST Arend Van Spriel wrote:
>>> If you want a separate property, then I repeat my very first
>>> suggestion, the well defined model property.
>>> e.g.
>>>
>>> brcmf at 0 {
>>>         model = "ampak,ap6210";
>>>         compatible = "brcm,bcm4329-fmac";
>>>         ...
>>> };
>>>
>>> All device nodes may have a model property, not just the top "machine" one.
>>
>> I heard you the first time  I just was not sure what the implications
>> would be to use it. Hence I suggested a vendor specific property.
>> However, looking up and reading the definition in ePAPRv1.1 I suppose it
>> is fine to use the model property:
>>
>> Property: model
>> Value type: <string>
>> Description:
>> The model property value is a <string> that specifies the manufacturer?s
>> model number of the device.
>>
>> The recommended format is: ?manufacturer,model?, where manufacturer is a
>> string describing the name of the manufacturer (such as a stock ticker
>> symbol), and model specifies the model number.
> 
> The model property is very similar to compatible, except that there is
> only one entry rather than a list of entries from most specific to
> most generic.

They seem very similar, but I think there is a conceptual difference.
The compatible property is mainly used to select the appropriate driver
and as such the property is typically ignored by device drivers.
Probably there are exceptions to be found.

> I think by writing the above example as
> 
> 	compatible = "ampak,ap6210", "brcm,bcm4329-fmac";
> 
> we can provide the same functionality in a slightly simpler way, the driver
> then just goes on to look for the nvram file for each entry in sequence until
> it finds one.

Not sure why this would be simpler. Why would traversing the compatible
string be simpler than handling the model property if present and
otherwise fallback to the default nvram naming.

Regards,
Arend
