From: ben@trinity.fluff.org (Ben Dooks)
Date: Thu, 10 May 2012 11:43:11 +0100
Subject: Handling of modular boards
In-Reply-To: <4FA432E9.9050606@wwwdotorg.org>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <4FA432E9.9050606@wwwdotorg.org>
Message-ID: <20120510104311.GB30103@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 01:50:01PM -0600, Stephen Warren wrote:
> On 05/04/2012 12:58 PM, Mark Brown wrote:
> > Quite a few reference platforms (including Wolfson ones, which is why
> > I'm particularly interested) use replaceable modules to allow
> > configuration changes.  Since we can often identify the configuration at
> > runtime we should ideally do that but currently there's no infrastructure 
> > to help with that...
> 
> So, I'll respond within the context of device tree, although perhaps you
> were looking for something more general?
> 
> I was just asked basically the same question internally to NVIDIA. One
> option that was floated was to store the device tree in chunks and have
> the bootloader piece them together. You'd start with the DT for the
> basic CPU board, probe what HW was available, and then graft in the
> content of additional DT chunks and pass the final result to the kernel.
> The advantages here are:
> 
> a) The DT is stored in chunks for each plugin board, so there's no bloat
> in the DT that gets passed to the kernel; it contains exactly what's on
> the board.

Interesting, but how does it sort ofu things like mapping GPIO lines from
the add-in board's view to the rest of the system?


-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
