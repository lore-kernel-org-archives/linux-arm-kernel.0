From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 5 Nov 2010 13:39:30 +0200
Subject: build failure on ARMv7 while CONFIG_AEABI is disabled
In-Reply-To: <AANLkTimv-bW56P+M9X+Unr4QotCTwhjaw+kOCNP3qbgD@mail.gmail.com>
References: <AANLkTimv-bW56P+M9X+Unr4QotCTwhjaw+kOCNP3qbgD@mail.gmail.com>
Message-ID: <20101105113930.GG13530@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Fri, Nov 05, 2010 at 07:22:09PM +0800, Haojian Zhuang wrote:
> Hi all,
> 
> If I disable CONFIG_AEABI, building kernel for ARMv7. There's no issue
> on ARMv5. Do you have any clue?

Does the patch in the link below helps?

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/030570.html

> /tmp/ccaEQuAe.s: Assembler messages:
> /tmp/ccaEQuAe.s:88: Error: even register required -- `ldrexd r7,r8,[r4]'
> /tmp/ccaEQuAe.s:104: Error: even register required -- `strexdeq ip,r5,r6,[r4]'
> /tmp/ccaEQuAe.s:125: Error: even register required -- `ldrexd r1,r2,[r0]'
> /tmp/ccaEQuAe.s:128: Error: even register required -- `strexd ip,r1,r2,[r0]'
> /tmp/ccaEQuAe.s:2086: Error: even register required -- `ldrexd r1,r2,[r0]'
> /tmp/ccaEQuAe.s:2101: Error: even register required -- `ldrexd r3,r4,[r0]'
> /tmp/ccaEQuAe.s:2102: Error: even register required -- `strexd r3,r5,r6,[r0]'
> /tmp/ccaEQuAe.s:2135: Error: even register required -- `ldrexd r5,r6,[r2]'
> /tmp/ccaEQuAe.s:2136: Error: even register required -- `strexd r5,r3,r4,[r2]'
> /tmp/ccaEQuAe.s:2165: Error: even register required -- `ldrexd r3,r4,[r0]'
> /tmp/ccaEQuAe.s:2166: Error: even register required -- `strexd r3,r1,r2,[r0]'
> /tmp/ccaEQuAe.s:3186: Error: even register required -- `ldrexd r3,r4,[r0]'
> /tmp/ccaEQuAe.s:3187: Error: even register required -- `strexd r3,r1,r2,[r0]'
> make[2]: *** [arch/arm/kernel/perf_event.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/arm/kernel] Error 2

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
