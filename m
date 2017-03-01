From: eric@anholt.net (Eric Anholt)
Date: Wed, 01 Mar 2017 10:00:55 -0800
Subject: [PATCH v3 2/7] mmc: bcm2835: Add new driver for the sdhost
 controller.
In-Reply-To: <1487668026-7100-3-git-send-email-kraxel@redhat.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-3-git-send-email-kraxel@redhat.com>
Message-ID: <87tw7c27xk.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> The 2835 has two SD controllers: The Arasan sdhci controller (supported
> by the iproc driver) and a custom sdhost controller.  This patch adds a
> driver for the latter.
>
> The sdhci controller supports both sdcard and sdio.  The sdhost
> controller supports the sdcard only, but has better performance.  Also
> note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
> controller allows to use the sdhci controller for wifi support.
>
> The configuration is done by devicetree via pin muxing.  Both SD
> controller are available on the same pins (2 pin groups = pin 22 to 27 +
> pin 48 to 53).  So it's possible to use both SD controllers at the same
> time with different pin groups.
>
> The code was originally written by Phil Elwell in the downstream
> Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> out of the original 2055) for inclusion.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Ulf, what do you need done to this driver patch before it can go in?
The commit message seems like it could use some rewriting at this point
(Personally I would drop the detailed changelogs from Stefan and Gerd,
updating the last paragraph here to give them credit), but what's
important to me is getting the driver in so that distros don't have to
carry this patch for wifi support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/2f4adaaf/attachment.sig>
