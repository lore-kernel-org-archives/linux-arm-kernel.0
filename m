From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jun 2016 23:26:15 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Add a startup delay for fixed
 regulator enabled phys
In-Reply-To: <1465037919-8497-1-git-send-email-hdegoede@redhat.com>
References: <1465037919-8497-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160607212615.GG14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 04, 2016 at 12:58:39PM +0200, Hans de Goede wrote:
> It seems that recent kernels have a shorter timeout when scanning for
> ethernet phys causing us to hit a timeout on boards where the phy's
> regulator gets enabled just before scanning, which leads to non working
> ethernet.
> 
> A 10ms startup delay seems to be enough to fix it, this commit adds a
> 20ms startup delay just to be safe.
> 
> This has been tested on a sun4i-a10-a1000 and sun5i-a10s-wobo-i5 board,
> both of which have non-working ethernet on recent kernels without this
> fix.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/4054156d/attachment.sig>
