From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Jun 2014 11:43:38 +0100
Subject: [PATCHv2 00/24] ILP32 Support in ARM64
In-Reply-To: <6ABA4097-FE5B-4F52-A4A0-C289836919F6@caviumnetworks.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <20140616170808.GA5362@arm.com>
 <6ABA4097-FE5B-4F52-A4A0-C289836919F6@caviumnetworks.com>
Message-ID: <20140617104338.GA21752@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 05:19:32PM +0000, Pinski, Andrew wrote:
> > On Jun 16, 2014, at 10:08 AM, "Catalin Marinas" <catalin.marinas@arm.com> wrote:
> >> On Sat, May 24, 2014 at 12:01:55AM -0700, Andrew Pinski wrote:
> >> New version of the patches with documentation, signal changes are
> >> simplified, using less compat syscalls and splitting up the patches so
> >> it is easier to review.  I have tested LTP on both LP64 and ILP32.
> >> There is a few LTP failures but they are due to LTP being incorrect
> >> (sigaction structure in glibc is not the one which is used by the
> >> kernel)
> > 
> > Do you have more details about what's wrong here and where the fix
> > should go? LTP? glibc? Kernel?
> 
> LTP assumes some sigaction structure is the same between userland and kernel.
> Glibc has the correct idea of what the kernel structure will be when
> passing to the kernel already. The fix should be done in LTP. There is
> already code in LTP for x86 for a similar issue which we should be
> able to advantage of. 

OK. I guess you are planning to submit the LTP patch at some point (once
kernel and glibc changes are agreed).

Any plans for big-endian ILP32?

> > I'll give you more specific comments on the code in the next couple of
> > days. But for cosmetics, please wrap the lines around 72 (or whatever)
> > characters both in emails, commit logs and Documentation/* files (and
> > you can drop the "Thanks" part in every commit log ;)).

I forgot to mention dropping the full stop at the end of every subject.

> Will do this with the rest of the review. 

More coding style issues: please have a look at
Documentation/CodingStyle. While I'm not usually bothered with minor
aspects, I would like at least some consistency for multi-line comment
style.

Also please get the patches through checkpatch.pl (it doesn't need to be
100% pass but it gives some clues).

There are a few #defines you added without corresponding brackets (hpa
commented on one already).

-- 
Catalin
