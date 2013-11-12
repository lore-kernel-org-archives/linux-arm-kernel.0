From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 12 Nov 2013 10:20:10 -0500 (EST)
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <alpine.LFD.2.10.1311120948000.9667@knanqh.ubzr>
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.10.1311092357090.2314@knanqh.ubzr>
 <528193A0.7050505@codeaurora.org>
 <alpine.LFD.2.10.1311120839310.9667@knanqh.ubzr>
 <20131112140436.GK16735@n2100.arm.linux.org.uk>
 <52823877.60806@codethink.co.uk>
 <alpine.LFD.2.10.1311120924330.9667@knanqh.ubzr>
 <yw1x8uwtvg3i.fsf@unicorn.mansr.com>
 <alpine.LFD.2.10.1311120948000.9667@knanqh.ubzr>
Message-ID: <alpine.LFD.2.10.1311121014530.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013, Nicolas Pitre wrote:

> On Tue, 12 Nov 2013, M?ns Rullg?rd wrote:
> 
> > It might be possible to extract this information from relocation tables.
> 
> True, but only for individual .o files.  Once the linker puts them 
> together the information is lost, and trying to infer what the linker 
> has done is insane.
> 
> Filtering the compiler output to annotate idiv calls before it is 
> assembled would probably be a better solution.

Another solution is to patch the call site from within __aeabi_idiv at 
run time using lr.  That wouldn't work in the presence of tail call 
optimization though.

Again this might not be worth it and patching __aeabi_idiv instead might 
be a good enough compromize.


Nicolas
