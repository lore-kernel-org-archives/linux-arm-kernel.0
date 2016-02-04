From: bcrl@kvack.org (Benjamin LaHaise)
Date: Thu, 4 Feb 2016 09:32:04 -0500
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204141253.GF10826@n2100.arm.linux.org.uk>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org> <20160127134024.0fababf6@canb.auug.org.au>
 <20160129113056.GP10826@n2100.arm.linux.org.uk>
 <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au> <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
 <20160204140822.GB16315@kvack.org>
 <20160204141253.GF10826@n2100.arm.linux.org.uk>
Message-ID: <20160204143204.GC16315@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 02:12:53PM +0000, Russell King - ARM Linux wrote:
> Hence, __get_user() on x86-32 with a 64-bit quantity results in
> __get_user_bad() being called, which is an undefined function.
> Only if you build with x86-64 support enabled (iow, CONFIG_X86_32 not
> defined) then you get the 64-bit __get_user() support.
> 
> Given this, I fail to see how x86-32 can possibly work.

You're right; mea culpa.  It compiles without warning on x86-32, but it 
does not link.  I still think this is broken archtecture stupidity since 
put_user() works for 64 bit data types.

		-ben
-- 
"Thought is the essence of where you are now."
