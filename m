From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Apr 2015 09:11:00 +0200
Subject: [PATCH] ARM: at91/dt: kizbox: update and rename to at91-kizbox
In-Reply-To: <1429521218-9752-1-git-send-email-g.portay@overkiz.com>
References: <1429521218-9752-1-git-send-email-g.portay@overkiz.com>
Message-ID: <20150421091100.6bb8ba36@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gael,

On Mon, 20 Apr 2015 11:13:38 +0200
Ga?l PORTAY <g.portay@overkiz.com> wrote:

> Sort nodes, rename to match Atmel naming convention

You should use -M when you generate your patches with format-patch: it
keeps track of files that have been renamed instead of considering it
as a removal + an addition.

> and update the features
> below:
>  - command-line,
>  - use proper serial uart,
>  - rename leds and gpio-keys,
>  - update to pwm-leds and
>  - fix gpio-key level.

Please split this patch so we can easily review the changes.
How about the following separation ?

- rename dts file
- use stdout-path
- sanitize bootargs
- led related changes (rename + pwm-leds)
- gpio-key related changes (rename + fix level)

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
