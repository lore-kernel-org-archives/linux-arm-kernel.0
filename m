From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Jan 2011 05:15:53 +0200
Subject: [PATCH v2] omap2: fix DPLL_FREQSEL calculation
In-Reply-To: <8739on1wdd.fsf_-_@vostro.fn.ogness.net>
References: <87ei8726wf.fsf@vostro.fn.ogness.net>
	<20110120111645.GB2223@legolas.emea.dhcp.ti.com>
	<8739on1wdd.fsf_-_@vostro.fn.ogness.net>
Message-ID: <20110121031553.GA2448@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 03:29:50PM +0100, John Ogness wrote:
> On 2011-01-20, Felipe Balbi <balbi@ti.com> wrote:
> > scripts/get_maintainer.pl would've helped you getting a better Cc
> > list. I'm adding linux-omap and lakml
> 
> Thanks.
> 
> After investigating the issue further it seems that I had it
> backwards. The value of "n" is the value to divide by, not the value
> that goes in the register. This means that it is _dpll_test_fint()
> that is doing it incorrectly. Here is a new version of the patch to
> fix the right function.

you might want to look at Documentation/SubmittingPatches before sending
these patches. If anyone applies this patch of yours the commitlog will
have all the comments you've made above. Generally, patches are
"standalone" emails, without a discussion on them, if you want to add
comments which aren't supposed to go into commit log, then do so after
the tear line (---) and before the diff --git line; that way, git will
know it must drop that part of the comments.

-- 
balbi
