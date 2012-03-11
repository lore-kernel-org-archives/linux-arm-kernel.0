From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 11 Mar 2012 12:58:00 +0000
Subject: [PATCH 03/11] regulator: fixed: Support driver probe deferral
In-Reply-To: <1331218291-16119-4-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-4-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120311125759.GH3233@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 03:51:23PM +0100, Thierry Reding wrote:
> If the specified GPIO is not found, return -EPROBE_DEFER. This will
> cause the driver to be probed again later when the required GPIO may
> have become available.

Might be worth pushing this into gpiolib?  It seems like wanting to
defer if a GPIO is not found will be the overwhelmingly common case
given that the GPIO numbers need to be explicitly specified.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120311/ee0f2383/attachment-0001.sig>
