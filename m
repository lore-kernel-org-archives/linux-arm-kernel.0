From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 24 Jan 2018 07:17:25 +0100
Subject: [net-next: PATCH v4 1/7] device property: Introduce
 fwnode_get_mac_address()
In-Reply-To: <CAJZ5v0jpGb8_rSTdtoLJW9os0ufgwLTnbWAQq6MTy_ye6Hr6KA@mail.gmail.com>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
 <1516278704-17141-2-git-send-email-mw@semihalf.com>
 <CAJZ5v0j=4Lvaf49oeDqVmYP5nyAs-E9E8xdgyfL7=J_46X5TMA@mail.gmail.com>
 <CAPv3WKf0GUE508P8k1nExBA+h6pQr4UcaFPk+mps3xRepESQmw@mail.gmail.com>
 <CAJZ5v0jpGb8_rSTdtoLJW9os0ufgwLTnbWAQq6MTy_ye6Hr6KA@mail.gmail.com>
Message-ID: <CAPv3WKfCRE46W9kKCvffN+SuPBKF1bchUBJNjUuOMoPUj8H0qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

2018-01-24 3:08 GMT+01:00 Rafael J. Wysocki <rafael@kernel.org>:
> On Tue, Jan 23, 2018 at 7:12 AM, Marcin Wojtas <mw@semihalf.com> wrote:
>> Hi Rafael,
>>
>>> >         if (res)
>>> >                 return res;
>>> >
>>> > -       return device_get_mac_addr(dev, "address", addr, alen);
>>> > +       return fwnode_get_mac_addr(fwnode, "address", addr, alen);
>>> > +}
>>> > +EXPORT_SYMBOL(fwnode_get_mac_address);
>>>
>>> That should be EXPORT_SYMBOL_GPL().
>>>
>>> I have overlooked that previously, sorry about that.
>>
>> The series landed yesterday in net-next, so I need to send a fix on
>> top.
>
> OK
>
>> Would you be ok with single patch fixing all EXPORT_SYMBOL()
>> occurences? Those would be 2 new routines:
>> - fwnode_get_mac_address
>> - fwnode_irq_get
>> and  2 already existing in the file:
>> - device_get_mac_address
>> - fwnode_graph_parse_endpoint
>>
>> Please let know, how you prefer to handle it?
>
> I guess it's better to fix this up when the series gets merged.
>

Ok, I will do it at that time.

Thanks,
Marcin
