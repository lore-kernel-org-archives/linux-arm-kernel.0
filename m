From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 25 Nov 2015 22:44:28 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <3245119.krc4KB3uae@wuerfel>
References: <20150713131902.GH26485@atomide.com>
 <20151125210310.GT2517@atomide.com> <3245119.krc4KB3uae@wuerfel>
Message-ID: <201511252244.28797@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 22:29:53 Arnd Bergmann wrote:
> On Wednesday 25 November 2015 13:03:10 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [151125 11:50]:
> > > On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> > > > At least I don't have better solutions in mind.
> > > 
> > > I would be happier if we could restrict this as much as possible
> > > to the boards that need it, as an opt-in. That way it doesn't
> > > become an ABI for people that don't already rely in this
> > > information. How about adding a check the code adds the
> > > linux,atags property to do it only for a whitelist of board
> > > numbers?
> > 
> > Or populate /proc/atags only for the ones that need it from machine
> > specific init_early?
> 
> That would also address my main concern about /proc/atags, but still
> leave the atags in /proc/device-tree/chosen/linux,atags, and it would
> be bad if someone who currently uses /proc/atags changes their code
> to use the other file instead of finding a proper solution.
> 
> 	Arnd

Arnd, my question about proper solution reminds... Proprietary 
bootloader which cannot be replaced (e.g. it is signed or do unknown 
magic) provides information to booted kernel via custom specific ATAGs 
fields. How userspace could properly read those custom information from 
bootloader?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151125/c65762fd/attachment.sig>
