From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 26 May 2016 09:26:06 -0700
Subject: [GIT PULL arm] Use _rcuidle tracepoints to allow tracing from idle
Message-ID: <20160526162606.GA20023@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Ingo,

This series changes a number of event tracepoints to their _rcuidle() form
to allow use from idle without lockdep-RCU complaints, a straightforward
modification that has been successfully applied many times.  These splats
were found in testing by Guenter Roeck and Tony Lindgren, who have
both successfully tested the full series.  Tony asked that I carry these
in -rcu:

	http://lkml.kernel.org/g/20160426213630.GV5995 at atomide.com

These have been posted to LKML, CCing relevant maintainers, who have
not objected to the proposed changes:

	http://lkml.kernel.org/g/20160516184844.GA20144 at linux.vnet.ibm.com

These maintainers are also CCed on this pull request.

They have also been subjected to 0day Test Robot and -next testing.

							Thanx, Paul
