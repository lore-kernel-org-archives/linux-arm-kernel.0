From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 14:40:25 +0100
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <20160303132956.GW19428@n2100.arm.linux.org.uk>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <3226743.49AyJYeiGh@wuerfel> <20160303132956.GW19428@n2100.arm.linux.org.uk>
Message-ID: <2601661.x1MEzJ9CK0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 13:29:56 Russell King - ARM Linux wrote:
> On Thu, Mar 03, 2016 at 01:56:56PM +0100, Arnd Bergmann wrote:
> > As Russell mentioned, the entire file is not really needed either, but
> > so far we have left the trivial per-platform files in place generally.
> 
> I think that's something we should be looking to remove: if the
> per-platform files give no benefit, then there is no point in
> having them, and they just increase the size of the code base.
> 

I agree, I think the main reason it hasn't been done yet is that
nobody has thought in detail about whether or how to keep
the last remaining piece of information (the machine name as
printed in /proc/cpuinfo) when removing the machine descriptors.

If we want to keep that around, we could probably have a global
lookup table of root node compatible strings, or we decide to
use the contents of the "model" property instead. This has been
discussed several times in the pasts, without any real consensus.

	Arnd
