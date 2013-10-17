From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 17 Oct 2013 11:27:13 -0400
Subject: [PATCH v3 6/7] arm64, jump label: optimize jump label
 implementation
In-Reply-To: <525FF6E0.7070000@gmail.com>
References: <1381893492-7135-1-git-send-email-liuj97@gmail.com>
 <1381893492-7135-7-git-send-email-liuj97@gmail.com>
 <20131016114608.GH5403@mudshark.cambridge.arm.com>
 <525EC8D1.7000900@gmail.com>
 <20131017093944.GB18765@mudshark.cambridge.arm.com>
 <525FF6E0.7070000@gmail.com>
Message-ID: <20131017112713.2638910f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Oct 2013 22:40:32 +0800
Jiang Liu <liuj97@gmail.com> wrote:


> >>> You could make the code more concise by limiting your patching ability to
> >>> branch immediates. Then a nop is simply a branch to the next instruction (I
> >>> doubt any modern CPUs will choke on this, whereas the architecture requires
> >>> a NOP to take time).
> >> I guess a NOP should be more effecient than a "B #4" on real CPUs:)
> > 
> > Well, I was actually questioning that. A NOP *has* to take time (the
> > architecture prevents implementations from discaring it) whereas a static,
> > unconditional branch will likely be discarded early on by CPUs with even
> > simple branch prediction logic.
> I naively thought "NOP" is cheaper than a "B" :(
> Will use a "B #1" to replace "NOP".
> 

Really?? What's the purpose of a NOP then? It seems to me that an
architecture is broken if a NOP is slower than a static branch.

-- Steve
