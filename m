From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 14:12:39 +0100
Subject: [PATCH v6 5/7] arm64/perf: Access pmu register using
 <read/write>_sys_reg
In-Reply-To: <20160425130637.GA29160@arm.com>
References: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
 <1461243525-13603-6-git-send-email-ashoks@broadcom.com>
 <20160425130637.GA29160@arm.com>
Message-ID: <20160425131238.GA30830@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 02:06:37PM +0100, Will Deacon wrote:
> On Thu, Apr 21, 2016 at 05:58:43AM -0700, Ashok Kumar wrote:
> > changed pmu register access to make use of <read/write>_sys_reg
> > from sysreg.h instead of accessing them directly.
> > 
> > Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> This doesn't apply on top of -rc1 + the first four patches in your series.
> What am I missing?

... the kvm changes, which we merged for -rc2. Sorry for the noise, I'll
base this on -rc3 (to match the for-next/core branch).

Will
