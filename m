From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 26 May 2013 07:38:37 +0200
Subject: [PATCH v7] arm: use built-in byte swap function
In-Reply-To: <20130523114654.1f273241725205c6703b2226@freescale.com>
References: <20130129181046.GC25415@pd.tnic>
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
 <1361661654.18110.102.camel@shinybook.infradead.org>
 <20130523114654.1f273241725205c6703b2226@freescale.com>
Message-ID: <51A19FDD.9040403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.05.2013 18:46, schrieb Kim Phillips:
> Enable the compiler intrinsic for byte swapping on arch ARM.  This
> allows the compiler to detect and be able to optimize out byte
> swappings, and has a very modest benefit on vmlinux size (Linaro gcc
> 4.8):

I'm no GCC tool chain expert, so I just have an understanding 
question: Could anyone kindly give a brief explanation (*) of what the 
advantage of this is on ARM?

http://comments.gmane.org/gmane.linux.kernel.cross-arch/16016

mentions "lwbrx/stwbrx on PowerPC, movbe on Atom". But for ARM?

I haven't understood yet why the __arch_swabXX() in 
arch/arm/include/asm/swab.h [1] aren't sufficient? How can this be 
done better? E.g. does anybody have a disassembly without/with this 
change to illustrate that?

Many thanks and best regards

Dirk

(*) or in case this already done provide a link. I couldn't find it in 
the discussion of this patch.

[1]

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/include/asm/swab.h
