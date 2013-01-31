From: david.woodhouse@intel.com (Woodhouse, David)
Date: Thu, 31 Jan 2013 22:11:25 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130131145947.f62474a0600848df86548b96@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
Message-ID: <1359670248.27468.13.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-31 at 14:59 -0600, Kim Phillips wrote:
> 
> - add new ARCH_DEFINES_BUILTIN_BSWAP (see Kconfig help).

Ick, no.

>   - if set, generic compiler header does not set HAVE_BUILTIN_BSWAPxx

It won't do that anyway if !ARCH_USE_BUILTIN_BSWAP. I don't see the
point in adding a new config option just for this.

If you want to define __HAVE_BUILTIN_BSWAPxx__ for yourself manually,
just go ahead and do so. As I said, if lots of architectures end up
doing it then we'll worry about cleaning things up when we've got a
better picture of who needs what.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/c8350417/attachment.bin>
