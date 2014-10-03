From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Oct 2014 08:56:23 +0100
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <542E4721.8040300@collabora.co.uk>
References: <20141002113742.2b521495@canb.auug.org.au>
 <14357384.nIoLZkacVq@wuerfel> <542E4721.8040300@collabora.co.uk>
Message-ID: <20141003075623.GU5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 08:50:09AM +0200, Javier Martinez Canillas wrote:
> Hello Arnd, Stephen,
> 
> I'm so sorry about the breakage, when I posted this patch I mentioned that
> it was meant for the 3.18-rc cycle once 3.18-rc1 was released [0]. Because
> it fixes a regression caused by a patch queued in the clock tree for 3.18.
> I should had been more explicit about the dependencies to avoid confusions.

If a patch is known to cause a regression, it shouldn't be going in during
the merge window _or_ the fix patch should also go in during the merge
window via the same route to resolve the regression before it's noticable.

Given the number of changes which go in during the merge window, waiting
for -rc to fix a known bug *before* the merge window is not on - it breaks
the ability to bisect during the period where bisect really is needed.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
