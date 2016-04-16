From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 16 Apr 2016 21:07:56 +0200
Subject: [PATCH 1/2] clocksource: sp804: Add support for OX810SE 24bit
 timer width
In-Reply-To: <CANLsYkyKkFZOnzQBMHUZ=_y-EfcheAfPTdUZYpPWf_EPREeO0A@mail.gmail.com>
References: <1459520559-13110-1-git-send-email-narmstrong@baylibre.com>
 <1459520559-13110-2-git-send-email-narmstrong@baylibre.com>
 <CANLsYkyKkFZOnzQBMHUZ=_y-EfcheAfPTdUZYpPWf_EPREeO0A@mail.gmail.com>
Message-ID: <57128D8C.4000801@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2016 05:33 PM, Mathieu Poirier wrote:
> On 1 April 2016 at 08:22, Neil Armstrong <narmstrong@baylibre.com> wrote:
Hi Matthieu,
Thanks for the review.

>> +       /* OX810SE Uses a special 24bit width */
>> +       if (of_device_is_compatible(np, "oxsemi,ox810se-rps-timer"))
>> +               width = 24;
> 
> Wouldn't it be better to add a new optional property for this?  If the
> property is not specified then we default to a width of 32.  Otherwise
> the new width is configured.  That way we don't have to add a new
> compatible string every time (however often) a special width is
> encountered.
As explained by Rob Herring, this HW is compatible with SP804 but is /not/ an IP from ARM
and has been customized to support 24bit.
Having a DT property for this width is not wanted actually since it makes no sense for the
original SP804 IP, so it should be handled per vendor.

> 
> Otherwise I think the code facelift looks good,
> Mathieu

Is there any other blocking points ?

The point to have a change on sp804 is to economize a new very similar driver for oxnas.

Neil
