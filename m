From: ccross@android.com (Colin Cross)
Date: Fri, 18 May 2012 11:05:22 -0700
Subject: [PATCH 0/2] bug fixes for coupled cpuidle
Message-ID: <1337364324-12171-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last modifications made to the coupled cpuidle patches introduced
two bugs that I missed during testing.  The online count was never
initialized, causing coupled idle to always wait and never enter the
ready loop.  That hid the second bug, the ready count could never be
decremented after exiting idle.

Len, these two patches could be squashed into patch 3 of the original
set.  If you do squash them, you could also add Rafael's tags to the
set (Reviewed-by on 1 and 2, acked-by on 3).  Or I can reupload the
whole stack as v5 if you prefer.
