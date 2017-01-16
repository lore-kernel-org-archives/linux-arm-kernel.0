From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 16 Jan 2017 18:29:00 +0000
Subject: [BUG] linux-next cannot compile in AES crypto code of ARM
In-Reply-To: <534751484590587@web17h.yandex.ru>
References: <534751484590587@web17h.yandex.ru>
Message-ID: <65230bb3-d3bf-ff6e-1bcb-c37ee4515c4e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/17 18:16, Icenowy Zheng wrote:
> I'm trying build linux-next for Allwinner H3 (ARMv7 SoC).
> 
> My compiler is GCC 6.2.0.

The patch to fix this[1] is already in Linux-next; alternatively you
could also go back to an older binutils (without ARMv8-M support) to
avoid it for the time being.

Robin.

[1]:https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg23076.html

> 
> When building, I got following error:
> ```
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S: Assembler messages:
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:21: Error: selected processor does not support `tt .req ip' in ARM mode
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movw tt,#:lower16:crypto_ft_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movt tt,#:upper16:crypto_ft_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movwls tt,#:lower16:crypto_fl_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movtls tt,#:upper16:crypto_fl_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `movw tt,#:lower16:crypto_it_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `movt tt,#:upper16:crypto_it_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r10,[tt,r10,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r11,[tt,r11,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `movwls tt,#:lower16:crypto_il_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `movtls tt,#:upper16:crypto_il_tab'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r4,[tt,r4,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r5,[tt,r5,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r6,[tt,r6,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r7,[tt,r7,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t1,[tt,t1,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t2,[tt,t2,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r9,[tt,r9,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr t0,[tt,t0,lsl#2]'
> /home/icenowy/git-repos/linux/arch/arm/crypto/aes-cipher-core.S:178: Error: ARM register expected -- `ldr r8,[tt,r8,lsl#2]'
> ```
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
