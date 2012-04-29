From: jcm@jonmasters.org (Jon Masters)
Date: Sun, 29 Apr 2012 02:38:23 -0400
Subject: Fixing audit on ARM
Message-ID: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

I've been playing around with getting ARM kernels built in more standard
Fedora configurations (as have a number of other members of the Fedora
ARM community). This has turned up a bunch of problems so far, which
is both good and bad. The upside is that we can all work together to
make sure some of these non-embedded features get more testing :)

Anyway. I'm sending a trivial fix that prevents systemd going into a
forkbomb OOM tailspin on all recent Fedora ARM kernels (unless we
turn off audit). Note that the fact that this has been corrupting
userspace up to this point suggests strongly to me that we should
be also considering turning off audit on ARM systems until it is
known that there are not other issues. But I can run my test
system successfully, so I submit this fix for review anyway.

Thanks,

Jon.
