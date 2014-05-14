From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 17:59:56 +0200
Subject: [PATCH] i2c: s3c2410: resume race fix
In-Reply-To: <1397254781-23833-1-git-send-email-dianders@chromium.org>
References: <1397254781-23833-1-git-send-email-dianders@chromium.org>
Message-ID: <20140514155956.GD12911@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 03:19:41PM -0700, Doug Anderson wrote:
> From: Olof Johansson <olof@lixom.net>
> 
> Don't unmark the device as suspended until after it's been re-setup.
> 
> The main race would be w.r.t. an i2c driver that gets resumed at the same
> time (asyncronously), that is allowed to do a transfer since suspended
> is set to 0 before reinit, but really should have seen the -EIO return
> instead.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/6da26b28/attachment.sig>
