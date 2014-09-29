From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 29 Sep 2014 22:59:23 +0200
Subject: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
In-Reply-To: <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20140929205922.GB2758@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 10:08:12AM +0200, Sjoerd Simons wrote:
> To enable the cros-ec-tunnel driver to be auto-loaded when build as a
> module add an of match table (and export it) to match the modalias
> information passed on to userspace as the Cros EC MFD driver registers
> the MFD subdevices with an of_compatibility string.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Applied to for-next, thanks!

However, since you are working on this driver: sparse rightfully
complains about:

drivers/i2c/busses/i2c-cros-ec-tunnel.c:97:44: warning: cast truncates bits from constant value (10000 becomes 0)

I don't know the EC protocol, can you check?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/556cfafe/attachment.sig>
