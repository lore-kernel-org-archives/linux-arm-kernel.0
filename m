From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 6 Feb 2013 09:02:04 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130205210436.670c62e26d2121330e87af35@freescale.com>
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
 <1359703995.23531.6.camel@shinybook.infradead.org>
 <20130205210436.670c62e26d2121330e87af35@freescale.com>
Message-ID: <1360141322.6066.4.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-05 at 21:04 -0600, Kim Phillips wrote:
> gcc -Os emits calls to __bswapsi2 on those platforms to save space
> because they don't have the single rev byte swap instruction.

Is that the right thing for GCC to do in that situation?

If so, perhaps we should be *providing* __bswap[sd]i2 functions for it
to use?

If not, perhaps there should be a PR filed?

Or is our use case justifiably different to the general case of '-Os'?
If so, why?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/b6a82cd6/attachment-0001.bin>
