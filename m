From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 26 May 2016 09:27:27 -0700
Subject: [GIT PULL arm] Use _rcuidle tracepoints to allow tracing from idle
In-Reply-To: <20160526162606.GA20023@linux.vnet.ibm.com>
References: <20160526162606.GA20023@linux.vnet.ibm.com>
Message-ID: <20160526162727.GA21784@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 09:26:06AM -0700, Paul E. McKenney wrote:
> Hello, Ingo,
> 
> This series changes a number of event tracepoints to their _rcuidle() form
> to allow use from idle without lockdep-RCU complaints, a straightforward
> modification that has been successfully applied many times.  These splats
> were found in testing by Guenter Roeck and Tony Lindgren, who have
> both successfully tested the full series.  Tony asked that I carry these
> in -rcu:
> 
> 	http://lkml.kernel.org/g/20160426213630.GV5995 at atomide.com
> 
> These have been posted to LKML, CCing relevant maintainers, who have
> not objected to the proposed changes:
> 
> 	http://lkml.kernel.org/g/20160516184844.GA20144 at linux.vnet.ibm.com
> 
> These maintainers are also CCed on this pull request.
> 
> They have also been subjected to 0day Test Robot and -next testing.

And this time actually including the pull request...  :-/

							Thanx, Paul

These changes are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to e7c38dda94b23965a3eb46ef4656bb8cb921933d:

  arm: Use _rcuidle suffix to allow clk_core_enable() to used from idle (2016-05-18 11:55:29 -0700)

----------------------------------------------------------------
Paul E. McKenney (6):
      arm: Use _rcuidle tracepoint to allow use from idle
      arm: Use _rcuidle for suspend/resume tracepoints
      arm: Add _rcuidle tracepoints to allow clk_core_disable() use from idle
      arm: Add _rcuidle suffix to allow rpm_idle() use from idle
      arm: Add _rcuidle suffix to allow rpm_resume() to be called from idle
      arm: Use _rcuidle suffix to allow clk_core_enable() to used from idle

 arch/arm/kernel/smp.c             |  2 +-
 arch/arm/mach-omap2/powerdomain.c |  9 +++++----
 drivers/base/power/runtime.c      | 14 +++++++-------
 drivers/clk/clk.c                 |  8 ++++----
 4 files changed, 17 insertions(+), 16 deletions(-)
