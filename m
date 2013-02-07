From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Feb 2013 10:32:17 +0200
Subject: OMAP baseline test results for v3.8-rc6
In-Reply-To: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
Message-ID: <20130207083217.GA15462@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 06, 2013 at 11:34:32PM +0000, Paul Walmsley wrote:
> Boot tests:
> 
> * am335xbone: hangs after "Starting kernel"
>   - Cause unknown
>   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
>   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
>   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg83942.html

After testing quite a lot and having help from other folks, the problem
(for me at least) was missing fdt_high in u-boot environment.

setenv fdt_high 0xffffffff

fixed everything.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/2a1c0bf4/attachment.sig>
