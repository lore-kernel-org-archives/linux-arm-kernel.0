From: eliad@wizery.com (Eliad Peller)
Date: Sun, 15 Mar 2015 10:43:35 +0200
Subject: [PATCH v6 2/6] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <20150313150047.GI5264@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-3-git-send-email-eliad@wizery.com>
 <20150313150047.GI5264@atomide.com>
Message-ID: <CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Kalle

On Fri, Mar 13, 2015 at 5:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Eliad Peller <eliad@wizery.com> [150312 05:09]:
>> From: Luciano Coelho <luca@coelho.fi>
>>
>> Instead of defining an enumeration with the FW specific values for the
>> different clock rates, use the actual frequency instead.  Also add a
>> boolean to specify whether the clock is XTAL or not.
>
> Thanks for doing this. Just one comment on how we're going to get this
> all merged. Chances are this will cause merge conflicts between the
> wireless tree and the omap tree for the platform data and dts changes.
>
> Can you please separate the wireless changes in this series so we can
> do this in the following sets:
>
> 1. Add support for new things to wireless driver
>
> 2. Switch platform code to use the new support
>
> 3. Remove support for platform data with a follow-up patch
>
the series will still be dependent on each other (e.g. (3) must come
only after (2) was applied), so i'm not sure that will be very
helpful?

> The other option would be to have the whole series in a immutable
> branch against v3.0-rc1 that can be merged into both wirelss tree
> and omap tree.
>
i think that could be easier.

or maybe you can just take them all through the omap tree? the wlcore
tree is not under active development, so i don't expect conflicts
there.

Eliad.
