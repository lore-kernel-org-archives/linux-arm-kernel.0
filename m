From: sven@narfation.org (Sven Eckelmann)
Date: Sun, 8 May 2011 11:33:48 +0200
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <20110508092403.GB27807@n2100.arm.linux.org.uk>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
	<20110508092403.GB27807@n2100.arm.linux.org.uk>
Message-ID: <201105081133.50824.sven@narfation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
[...]
> Do we need atomic_dec_not_zero() et.al. in every arch header - is there no
> generic header which it could be added to?

Mike Frysinger already tried to answer it in 
<BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>:
> that's what asm-generic is for.  if the arch isnt using it, it's
> either because the arch needs to convert to it, or they're using SMP
> and asm-generic doesnt yet support that for atomic.h.
>
> for example, the Blackfin port only needed updating for the SMP case.
> in the non-SMP case, we're getting the def from asm-generic/atomic.h.
> -mike

Feel free to change that but I just followed the style used by all other 
macros and will not redesign the complete atomic*.h idea.

thanks,
	Sven
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110508/c3123ca9/attachment.sig>
