From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 12:26:53 +0200
Subject: [PATCH] i2c: mux: Use subsys_initcall for the
 i2c-arb-gpio-challenge
In-Reply-To: <1398351922-1647-1-git-send-email-ch.naveen@samsung.com>
References: <1398351922-1647-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140521102653.GK2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 08:35:22PM +0530, Naveen Krishna Chatradhi wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> Since many drivers rely on FETs that live behind this arbitrator, they
> can't successfully probe until after the arbitrator comes up.  They
> ought to handle things properly with EPROBE_DEFER and still work, but
> that has some downsides:
> 
> 1. Those drivers don't come up till later in the boot process.  That
>    really not so nice for the LCD--we want that to init early.
> 2. Some drivers have bugs and don't handle EPROBE_DEFER.  Those
>    drivers should be fixed but not all of them have been fixed yet.
>    HDMI is one example since DRM doesn't really have good support for
>    deferring probes.
> 
> With this change We end up using the same init level as the main i2c bus.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-on: https://gerrit.chromium.org/gerrit/57007
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Same here. Unless we have a clear understanding that this is the only
acceptable solution in mainline, this is really an out-of-tree patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/ff8fe38a/attachment.sig>
