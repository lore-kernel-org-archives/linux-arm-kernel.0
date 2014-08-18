From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 19 Aug 2014 00:50:59 +0200
Subject: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <53F25AD1.8040504@ti.com>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <53F244DA.3070803@ti.com>
 <20140818154112.6601cbff@gandalf.local.home>
 <53F25AD1.8040504@ti.com>
Message-ID: <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mugunthan,

On Mon, Aug 18, 2014 at 9:58 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>
>> Thus, for this patchset, as is:
>>
>> Tested-by: Steven Rostedt <rostedt@goodmis.org>
>
> This will fail for DRA7xx not in AM33xx
>

cpsw_am33xx_cm_get_macid() checks for
of_machine_is_compatible("ti,am33xx") and returns 0 if the machine is
not an am33xx. cpsw_probe_dt() only propagates the return value if is
not 0 so this patch does not change the semantics for other SoCs
besides am33xx.

If the driver already fails for DRA7xx that certainly is not this
patch's fault. Of course it would be nice to add support for DRA7xx as
well but I think that could be a follow-up patch and shouldn't be a
blocker to merge this change if is useful for users.

> Regards
> Mugunthan V N
> --

Best regards,
Javier
