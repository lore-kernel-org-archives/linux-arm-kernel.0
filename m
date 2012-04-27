From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:12:19 +0530
Subject: [PATCH V3 0/8] SPEAr: Move to common clock framework
In-Reply-To: <cover.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A23AB.5080704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> Mike,
> 
> You can apply all these patches as they don't have any dependency left (leaving
> the ones included here) and will now apply cleanly over linux-next.

Mike,

These patches give compilation errors over your clk-next branch.
This happened due to following patch.

commit 1c0035d710dd3bfa86d58f851b8737c7f11a9bbc
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Thu Apr 12 20:50:18 2012 +0800

    clk: pass parent_rate into .set_rate
    
    For most of .set_rate implementation, parent_rate will be used, so just
    like passing parent_rate into .recalc_rate, let's pass parent_rate into
    .set_rate too.
    
    It also updates the kernel doc for .set_rate ops.
    
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Signed-off-by: Mike Turquette <mturquette@linaro.org>

I will send fixups as reply on individual patches, and then send you pull request
with these changes squashed to parent commits.

-- 
viresh
