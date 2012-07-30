From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Jul 2012 13:53:59 -0700
Subject: [RFC 0/6] ARM: OMAP3+: minor PM core code cleanup
In-Reply-To: <1342197459-7920-1-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Fri, 13 Jul 2012 19:37:33 +0300")
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Message-ID: <871ujtgec8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero, Paul,

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> Following set moves some PRM related code away from PM core code to
> PRM / HWMOD. This requires the hwmod cleanup set from Paul that
> implements the setup_preprogram hooks for hwmods. Sending as RFC for
> initial commenting.

What is the status of the setup_preprogram hooks patch(es)?  Looks like
that part was dropped from Paul's original series of fixes.

Just curious,

Kevin

> This set does following:
> - gets rid of the prcm interrupt handler from pm34xx.c
> - removes iva_idle from pm34xx.c
> - removes d2d_idle from pm34xx.c
>
> There are some side-effects though, it looks like the reset statuses
> for iva / d2d modules are rather flaky, and some failed hardreset
> warnings are generated during boot. PM works fine though and the
> modules are put to idle properly. Could use some ideas how to handle
> this, maybe add a flag for ignoring the hardreset status completely...?
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
