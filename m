From: khilman@ti.com (Kevin Hilman)
Date: Wed, 16 May 2012 16:17:23 -0700
Subject: [PATCHv2 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR registers
 when MPU hits OSWR/OFF mode
In-Reply-To: <1336990730-26892-12-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 14 May 2012 13:18:42 +0300")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-12-git-send-email-t-kristo@ti.com>
Message-ID: <87sjez67i4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
> overwrites the CM L3INSTR registers. So to avoid this, save them and
> restore on the way out from MPU OSWR/OFF.
>
> This errata applies to all HS/EMU versions of OMAP4.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [t-kristo at ti.com: added omap4 pm errata support]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Let's use the cluster PM notifiers here too, using the PM errata check
when registering the notifier.

Kevin
