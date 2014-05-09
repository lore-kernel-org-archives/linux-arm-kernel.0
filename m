From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 12:44:11 +0300
Subject: [PATCH v2 0/4] Support for Variscite OM44 modules and boards
In-Reply-To: <CAGhQ9VystybERsiPUX4ESNBcKPKBN44GvuPUtTM+jpywUqON3A@mail.gmail.com>
References: <1398971269-20515-1-git-send-email-manabian@gmail.com>	<20140506001530.GL25949@atomide.com>
 <CAGhQ9VystybERsiPUX4ESNBcKPKBN44GvuPUtTM+jpywUqON3A@mail.gmail.com>
Message-ID: <536CA36B.6000101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/14 21:02, Joachim Eastwood wrote:
> 1On 6 May 2014 02:15, Tony Lindgren <tony@atomide.com> wrote:
>> * Joachim Eastwood <manabian@gmail.com> [140501 12:08]:
>>> Hello,
>>>
>>> This patch set adds support for Variscite OM44 series of system on modules and boards.
>>>
>>> There weren't many comments on v1 of this patch set so I hope this can make it into 3.16.
>>> Changes since v2:
>>>  * Use OMAP IOPAD macros
>>>
>>> Patch 1: Add support for the SoM itself and the reference carrier board. Together these make the VAR-STK-OM44 dev kit.
>>> Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LCD display.
>>> Patch 3: Nodes for WLAN/BT support.
>>> Patch 4: Add quirks so that WLAN can be used. Still waiting for proper DT bindings.
>>>
>>> Since this patch set now uses the IOPAD macros a fix from Tony is need.
>>> See: https://patchwork.kernel.org/patch/4025421/
>>
>> Just noted that the macro won't work while was about to
>> apply these, sorry. So we're back to either using the
>> existing OMAP4_WKUP_IOPAD or raw offset from the padconf
>> area unless you have some great macro ideas.
> 
> I see. I'll take another look at the macro's and see what I can come up with.
> 
>>> Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpio (hotplug detect) to the "hdmi-connector".
>>> See: http://marc.info/?l=linux-omap&m=139771947508021&w=2
>>>
>>> Patch 2 also relies upon a patch from Tomi that adds DT support to panel-dpi.
>>> See: http://marc.info/?l=devicetree&m=139030201815380&w=2
>>
>> Maybe also leave out the DSS changes until Tomi has confirmed
>> those?
> 
> I can split the patch set and put a patch with the DSS DT nodes at the
> end. Maybe this last patch can go through Tomi if he has a DSS DT
> branch. I don't want to drop it entirely from the patch set because
> some other people has expressed interest in testing it with full
> display and hdmi support.

I have the HDMI and panel-dpi patches queued for 3.16. As this is a new
board, and there's no compile time dependency on DSS stuff, I think all
these patches can go through Tony.

For the display related parts in these patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/1ddeb4c1/attachment-0001.sig>
