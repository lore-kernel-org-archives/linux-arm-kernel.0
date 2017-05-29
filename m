From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 29 May 2017 10:07:30 +0300
Subject: [PATCHv3 1/3] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
In-Reply-To: <20170526154416.GC3717@atomide.com>
References: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
 <1495127772-7486-2-git-send-email-t-kristo@ti.com>
 <20170526154416.GC3717@atomide.com>
Message-ID: <5df79d6b-352d-8341-4bd0-fec4e4cc322d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/17 18:44, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170518 10:19]:
>> Fix the main clock assignment to assign clkctrl clk from DT as the main
>> clock if available. If main clock is assigned via DT, the direct PRCM
>> access for module handling is not used on OMAP4+ architectures either,
>> as it is assumed the main clock will be doing this instead.
>
> Is this still needed based on what we chatted last week?
>
> I'd like to avoid adding the clkctrl clocks to the wrong node
> as we then end up moving them again later on when we have support
> for the wrapper device..
>
> Regards,
>
> Tony
>

I am investigating this currently, don't have much input yet but an 
alternative solution seems rather plausible. If I can get it working, we 
don't need this specific patch, but something that will replace it.

-Tero
