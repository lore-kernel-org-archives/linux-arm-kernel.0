From: david.woodhouse@intel.com (Woodhouse, David)
Date: Fri, 8 Feb 2013 17:25:17 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130207181315.GM17833@n2100.arm.linux.org.uk>
References: <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
 <20130201011712.GF23505@n2100.arm.linux.org.uk>
 <1359703995.23531.6.camel@shinybook.infradead.org>
 <20130205210436.670c62e26d2121330e87af35@freescale.com>
 <1360141322.6066.4.camel@shinybook.infradead.org>
 <20130206191905.ac8eb6743e69425f30888704@freescale.com>
 <20130207181315.GM17833@n2100.arm.linux.org.uk>
Message-ID: <1360344301.6066.263.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-07 at 18:13 +0000, Russell King - ARM Linux wrote:
> 
> However, the biggest reason not to use libgcc is that we want to control
> what gets used in the kernel - for example, no floating point, and no
> use of 64 x 64bit division.

Which is all very sensible. But there's no particular reason we couldn't
add a __bswap[sd]i2 to the kernel's version of libgcc if we wanted to.

If we're compiling with -Os  on platforms without 'rev' and that's the
thing that makes most sense, then we should make it work.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/5ac63cff/attachment.bin>
