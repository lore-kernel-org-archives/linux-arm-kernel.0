From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Sep 2014 09:38:41 -0700
Subject: [PATCH] spi: davinci: request cs_gpio's from probe
In-Reply-To: <5416E462.7010406@ti.com>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
 <20140913162858.GG7960@sirena.org.uk> <5416E462.7010406@ti.com>
Message-ID: <20140915163841.GU7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 04:06:42PM +0300, Grygorii Strashko wrote:

> The function davinci_spi_cleanup() will be reused by following patch
> "[PATCH v3] spi: davinci: add support for adding delay between word's transmissions"
> http://www.spinics.net/lists/devicetree/msg49141.html

> So, in broonie/spi.git/for-next it will not be empty.

> Again, I've missed description of this dependency, sorry for that.

Don't do things like this, delete the function and then re-add it - it
makes the review simpler and it means that if the second patch doesn't
get applied (as will happen here for v3.17) then the code still looks
good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/88c49bd2/attachment.sig>
