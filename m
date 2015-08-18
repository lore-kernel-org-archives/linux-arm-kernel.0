From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Aug 2015 10:38:18 +0100
Subject: [PATCH v8 1/7] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <55CC1410.1090900@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-2-git-send-email-dave.long@linaro.org>
 <20150811173121.GC29880@arm.com> <55CC1410.1090900@linaro.org>
Message-ID: <20150818093817.GE10301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Aug 13, 2015 at 04:50:40AM +0100, David Long wrote:
> On 08/11/15 13:31, Will Deacon wrote:
> > On Tue, Aug 11, 2015 at 01:52:38AM +0100, David Long wrote:
> >> +	REG_OFFSET_NAME(x30),
> >
> > Does this interact badly with perf tools, which expect to pass "lr" for
> > x30? (see tools/perf/arch/arm64/include/perf_regs.h).
> >
> 
> Possibly, I can test that when I'm back from my short vacation this 
> week.  The lr/x30 thing seems to be a recurring issue.  Perhaps it is 
> best simply to add a reundant entry for x30 as "lr".  It's simple enough 
> to do, although just slightly ugly looking as it would have to be done 
> without a macro.  Would one ever use "x31" in place of "sp"?

No; "sp" should always be "sp". Let me know how you get on with perf. I
couldn't quite tie the two ends together, but it does look like it expects
"lr" to work.

Will
