From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 13 Nov 2012 16:03:14 -0800
Subject: [PATCHv2] ARM: OMAP4: USB: power down MUSB PHY during boot
In-Reply-To: <20121109143033.GB10718@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Fri, 9 Nov 2012 16:30:34 +0200")
References: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
 <20121109143033.GB10718@arwen.pp.htv.fi>
Message-ID: <874nktgif1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> HI,
>
> On Fri, Nov 09, 2012 at 04:30:35PM +0200, Tero Kristo wrote:
>> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
>> PHY functions for OMAP4, but this causes a problem with core retention
>> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
>> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
>> 
>> Fixed by adding a minimal function back that disables the USB PHY during
>> boot.
>> 
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> looks good to me. I would still suggest adding a REVISIT or FIXME note
> stating that this should be moved to SCM driver eventually ;-)
>
> Other than that:
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks will try to get this in for v3.8 along with the original patch
4/9 which gets full-chip retention working on OMAP4.

Kevin
