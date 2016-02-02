From: rabin@rab.in (Rabin Vincent)
Date: Tue, 2 Feb 2016 18:31:41 +0100
Subject: [PATCH] recordmcount: arm: Implement make_nop
In-Reply-To: <20160201194432.GK4848@codeaurora.org>
References: <1454116686-30190-1-git-send-email-sboyd@codeaurora.org>
 <20160130184005.GA29607@debian>
 <20160201194432.GK4848@codeaurora.org>
Message-ID: <20160202173141.GB9044@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 11:44:32AM -0800, Stephen Boyd wrote:
> On 01/30, Rabin Vincent wrote:
> > For __gnu_mcount_nc, wouldn't it be better to replace both the push {lr}
> > and the bl with nop instructions, instead of keeping a (useless) push +
> > pop sequence?
> 
> Agreed. I was trying to do a 1-to-1 copy of the ftrace code on
> ARM.  I was wondering the same thing in that code path while
> doing this though. Can't we replace both instructions instead of
> one instruction when we're patching in nops at runtime?

As Steven pointed out the last time this came up, we can't do it safely
at runtime:

https://marc.info/?l=linux-arm-kernel&m=132517584531389&w=2
