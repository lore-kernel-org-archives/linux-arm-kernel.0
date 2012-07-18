From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 11:16:13 +0100
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
In-Reply-To: <20120718005230.GA15680@linux-sh.org>
References: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
 <20120718005230.GA15680@linux-sh.org>
Message-ID: <20120718101612.GE22739@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 09:52:30AM +0900, Paul Mundt wrote:
> On Tue, Jul 17, 2012 at 07:57:49PM +0100, Mark Brown wrote:

> > -next fails to boot for me today on my s3c64xx based systems.  Walking
> > back to the last time I tried and bisecting likely branches I find that
> > commit 910139 (irqdomain: Replace LEGACY mapping with LINEAR) is the one
> > that introduces the build break.  Unfortunately the boot fails before I
> > get a console which makes diagnosis somewhat more tricky than would be
> > ideal.  Any ideas?

> Does http://www.spinics.net/lists/linux-sh/msg11995.html fix it for you?

> I did Cc you on the legacy -> linear thread, but perhaps you missed it.

I do remember seeing it, it's a big part of how I isolated that this
patch series was the issue.  To be honest I hadn't got terribly far with
the diagnosis of what the actual breakage is, it took a while to isolate
as it had been a little while since I'd rebased through onto -next and
there's no diagnostics at all from the system when it fails.

I tried applying the patch but the underlying code has changed a lot so
patch gets upset, I'll try to find time to resolve them but can't
guarantee when as things are especially hectic right now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/28ea8fb1/attachment.sig>
