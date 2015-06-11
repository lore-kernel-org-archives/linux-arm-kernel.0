From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:15:33 -0700
Subject: [PATCH] ARM64: juno: add GPIO keys
In-Reply-To: <1433418072-10319-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Thu, 4 Jun 2015 13:41:12 +0200")
References: <1433418072-10319-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <7hioaudk0a.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The Juno board has two keys connected to a PL061 GPIO block,
> in accordance to DDI0524B "ARM Versatile Express Juno Development
> Platform" revision 1.0, table 2-4 "GPIO (0) and GPIO (1) used
> for additional user key entry". By trial-and-error I found that
> these are connected to the two keys named "power" and "home"
> on the motherboard.
>
> Register the GPIO block and these two keys in the device tree
> using the PL061 GPIO driver and the generic gpio keys.
>
> - Map POWER, HOME, VOL+ and VOL- to the obvious input events.
> - Map RLOCK to KEY_SCREENLOCK/KEY_COFFEE unless someone can
>   explain better what this is for.
> - Map the NMI button to KEY_SYSREQ as this is used like so
>   in the SYSREQ debugging hack.
>
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks, please apply this patch directly to
> the DT branch for ARM64. This is a resend of the v2 version
> with Liviu's ACK.

Applied to next/dt.

Thanks,

Kevin
