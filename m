From: broonie@kernel.org (Mark Brown)
Date: Sat, 25 May 2013 16:10:32 -0400
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
Message-ID: <20130525201032.GD32043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 06:25:39PM +0800, Barry Song wrote:
> 2013/5/16 Wolfram Sang <wsa@the-dreams.de>:

> > What about deferred probing?

> deferred probing could work but could not work for automative.
> what we really want is that devices begin to work as early as
> possible. we want i2c clients like lcd, camera begin to show images as
> early as possible as an automative requirement.

Probe deferral should have at most a mimimal impact on the boot time -
it's pretty much just changing the order providing the probe functions
aren't excessively slow to defer.  If the probe functions are taking a
long time to defer that's probably what needs looking at.

If it really is probe deferral itself that's too slow then we ought to
be looking at improving that rather than boding around it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130525/841929cb/attachment.sig>
