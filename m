From: david.woodhouse@intel.com (Woodhouse, David)
Date: Sat, 23 Feb 2013 23:20:56 +0000
Subject: [PATCH v6] arm: use built-in byte swap function
In-Reply-To: <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
References: <20130129181046.GC25415@pd.tnic>
 <1360363233.6066.283.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081745500.6300@xanadu.home>
 <20130208191208.2ef3d78bda71aa7b44d00d7b@freescale.com>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
 <1361372008.13482.280.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
 <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
 <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
 <20130221005221.15279b1372501af12c1e4f32@freescale.com>
 <alpine.LFD.2.03.1302211134160.6419@syhkavp.arg>
 <20130221203327.6558f89277468f7ffffa6506@freescale.com>
 <alpine.LFD.2.03.1302212219100.6419@syhkavp.arg>
 <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
Message-ID: <1361661654.18110.102.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 19:40 -0600, Kim Phillips wrote:
> Enable the compiler intrinsic for byte swapping on arch ARM.  This
> allows the compiler to detect and be able to optimize out byte
> swappings, and has a tiny benefit on vmlinux size (Linaro gcc 4.7.3):
> 
>    text    data     bss     dec     hex filename
> 2754100  121144   56520 2931764  2cbc34 vmlinux-lart #orig
> 2754050  121144   56520 2931714  2cbc02 vmlinux-lart #builtin-bswap
> 6282699  307852 5578076 12168627 b9adb3 vmlinux-mxs #orig
> 6282241  307832 5578076 12168149 b9abd5 vmlinux-mxs #builtin-bswap
> 7200193  364180  361748 7926121  78f169 vmlinux-imx_v6_v7 #orig
> 7199515  364188  361748 7925451  78eecb vmlinux-imx_v6_v7 #builtin-bswap
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Looks good, thanks.

Acked-by: David Woodhouse <David.Woodhouse@intel.com>


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130223/266412f9/attachment.bin>
