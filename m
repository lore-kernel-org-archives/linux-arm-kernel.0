From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 25 Jul 2015 21:41:32 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <87oaj0ebvw.fsf@belgarion.home>
References: <Pine.LNX.4.44L0.1507231542520.25082-100000@netrider.rowland.org>
 <55B31FC9.1000407@tul.cz> <87oaj0ebvw.fsf@belgarion.home>
Message-ID: <55B3E66C.2030603@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.7.2015 13:04, Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> On 23.7.2015 21:46, Alan Stern wrote:
>>>> It seems that it allows using a BULK endpoint for requested INT
>>>> endpoint. For my PXA27x machine the original code returns BULK EP
>>>> even with valid INT endpoint definition (because BULK EPs are defined
>>>> earlier than INT EPs).
>>>
>>> Yes, it does allow a bulk endpoint to be used when an interrupt 
>>> endpoint was requested.  However, it won't return a bulk endpoint if 
>>> all the bulk endpoints are already in use.
> This cannot work for pxa27x.
> 
> The pxa27x IP has a hardware limitation which prevents an endpoint from changing
> its type once the UDC is enabled (see the comment at the beginning of
> pxa27x_udc.c).

Just crazy idea (based on how much I have to recompile kernel, when switching between testing gadgets), how much possible (EP allocation, no resource errors return, configuration/interface settings change) it would be to generate an EP configuration on the fly and only enabling the PXA27x when a set_configuration usb request is received?

Petr
