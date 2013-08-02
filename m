From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Aug 2013 12:12:25 +0200
Subject: [PATCH] pinctrl: sunxi: Fix gpio_set behaviour
In-Reply-To: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130802101225.GU2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Jul 25, 2013 at 12:41:16PM +0200, Maxime Ripard wrote:
> The current gpio_set function is ignoring the previous value set in the
> GPIO value register, which leads in erasing the values already set for
> the other GPIOs in the same bank when setting the value of a given GPIO.
> 
> Add the usual read/mask/write pattern to fix this brown paper bag bug.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This should probably go in 3.11. I'll send a patch adding locking like
Thomas suggested, could you queue up this patch for 3.11?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/1279d13b/attachment.sig>
