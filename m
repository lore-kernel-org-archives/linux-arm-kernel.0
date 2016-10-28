From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Oct 2016 12:11:46 +0100
Subject: [RFC][PATCH] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <CAKv+Gu9-Pm_j-3shoiGZY+8zMBjTpNOXOphwea+tdC4KPbie3Q@mail.gmail.com>
References: <1477613892-26076-1-git-send-email-labbott@redhat.com>
 <CAKv+Gu9-Pm_j-3shoiGZY+8zMBjTpNOXOphwea+tdC4KPbie3Q@mail.gmail.com>
Message-ID: <20161028111145.GG5806@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 08:52:50AM +0100, Ard Biesheuvel wrote:
> Hi Laura,
> 
> On 28 October 2016 at 01:18, Laura Abbott <labbott@redhat.com> wrote:
> > x86 has an option CONFIG_DEBUG_VIRTUAL to do additional checks
> > on virt_to_phys calls. The goal is to catch users who are calling
> > virt_to_phys on non-linear addresses immediately. As features
> > such as CONFIG_VMAP_STACK get enabled for arm64, this becomes
> > increasingly important. Add checks to catch bad virt_to_phys
> > usage.
> 
> I think this is a useful thing to have. However, the Kconfig
> description talks about virt to page translations, not virt to phys.
> Of course, this is a shift away from being equivalent on x86, but not
> so much on arm64. Any concerns there?

See commit 59ea746337c69f6a ("MM: virtual address debug"); the existing
x86 cases cover virt to phys also.

The Kconfig text does say "and friends"...

Thanks,
Mark.
