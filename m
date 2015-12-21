From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Dec 2015 15:41:49 +0000
Subject: next-20151221 build: 2 failures 13 warnings (next-20151221)
In-Reply-To: <201512211505.34074.arnd@arndb.de>
References: <E1aAyjj-0007DR-4T@optimist>
 <201512211505.34074.arnd@arndb.de>
Message-ID: <20151221154149.GK5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 03:05:33PM +0100, Arnd Bergmann wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Just looking at the remaining warnings/errors in linux-next:

> > Warnings:
> >         <stdin>:1307:2: warning: #warning syscall copy_file_range not implemented [-Wcpp]

> Not sure how we can improve this, the same thing seems to happen every time a new syscall gets
> introduced. The actual change is trivial, but we need a better method to sync all architectures.

Now we've got the warning count down sufficiently the autobuilders may
actually be just fine here.

> > arm-multi_v7_defconfig : PASS, 0 errors, 8 warnings, 0 section mismatches

> > Warnings:
> >         arch/arm/configs/multi_v7_defconfig:433:warning: symbol value 'm' invalid for MFD_DA9063

> I need to look into this, probably the result of a defconfig change we merged, but it's not
> clear whether the driver should be a module, or the defconfig should have it built-in.

The driver should at least support building modularly, there was a patch
sent to MFD IIRC but I guess it's not applied yet (Lee is on vacation I
believe which probably won't help).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/27093a0a/attachment.sig>
