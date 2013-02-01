From: david.woodhouse@intel.com (Woodhouse, David)
Date: Fri, 1 Feb 2013 07:33:17 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130201011712.GF23505@n2100.arm.linux.org.uk>
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
 <20130201011712.GF23505@n2100.arm.linux.org.uk>
Message-ID: <1359703995.23531.6.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-01 at 01:17 +0000, Russell King - ARM Linux wrote:
> 
> > I've tried both gcc 4.6.3 [1] and 4.6.4 [2].  If you can point me to
> > a 4.5.x, I'll try that, too, but as it stands now, if one moves the
> > code added to swab.h below outside of its armv6 protection,
> > gcc adds calls to __bswapsi2.
> 
> Take a look at the message I sent on the 29th towards the beginning of
> this thread for details of gcc 4.5.4 behaviour.

I'd like to see a comment (with PR# if appropriate) explaining clearly
*why* it isn't enabled for <ARMv6 even with a bleeding-edge compiler.

Russell's test also seemed to indicate that the 32-bit and 64-bit swap
support was present and functional in GCC 4.5.4 (as indeed it should
have been since 4.4), so I'm still not quite sure why you require 4.6
for that.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130201/d2606b09/attachment-0001.bin>
