From: carlo@caione.org (Carlo Caione)
Date: Sat, 1 Mar 2014 18:17:18 +0100
Subject: [PATCH 0/7] mfd: AXP20x: Add support for AXP202 and AXP209
In-Reply-To: <53121151.9050804@redhat.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <53121151.9050804@redhat.com>
Message-ID: <CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 1, 2014 at 5:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Carlo,
>
> Great work, thanks for all the time you're putting into this!

Hi Hans :)

> I've 2 questions:
>
> 1) What dependencies does this patch-set have? Obviously it needs the NMI irq
> patches for A20, anything else ?  I no longer see any use of a special flag
> for ack on unmask, is that no longer needed ?

Yes, the only dependency is on the NMI controller patch.
After a discussion with Maxime and Thomas I decided to not push for
including the special flag for ack on unmask in the irqchip core but
to use the unmask callback as in the v3 version of the NMI controller
driver (so no flag needed)

> 2) No poweroff functionality ? That would be really great to have.

Actually in [PATCH 1/7] I support the poweroff using the pm_power_off hook.

Best,

-- 
Carlo Caione
