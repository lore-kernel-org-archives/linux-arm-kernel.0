From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 9 Apr 2015 16:46:30 +0100
Subject: "tcp: refine TSO autosizing" causes performance regression on Xen
Message-ID: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I found a performance regression when running netperf -t TCP_MAERTS from
an external host to a Xen VM on ARM64: v3.19 and v4.0-rc4 running in the
virtual machine are 30% slower than v3.18.

Through bisection I found that the perf regression is caused by the
prensence of the following commit in the guest kernel:


commit 605ad7f184b60cfaacbc038aa6c55ee68dee3c89
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Dec 7 12:22:18 2014 -0800

    tcp: refine TSO autosizing


A simple revert would fix the issue.

Does anybody have any ideas on what could be the cause of the problem?
Suggestions on what to do to fix it?

Cheers,

Stefano
