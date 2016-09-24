From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Sep 2016 11:19:51 +0200
Subject: [PATCH v2] i2c: uniphier-f: fix misdetection of incomplete STOP
 condition
In-Reply-To: <1474637681-9589-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474637681-9589-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160924091951.GF1434@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 10:34:41PM +0900, Masahiro Yamada wrote:
> Currently, the status register FI2C_SR is checked immediately after
> a STOP condition is issued in case of the deferred STOP condition.
> It takes typically 5-10 usec until the corresponding bits in the
> register are set, so the error check for "stop condition was not
> completed" is very likely to be false positive.
> 
> Add wait code to relax the status register check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/977ad2d7/attachment.sig>
