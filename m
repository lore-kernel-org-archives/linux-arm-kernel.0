From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 Sep 2015 11:52:56 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1443206945.2161.9.camel@sipsolutions.net>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1443202945.2161.8.camel@sipsolutions.net>
 <20150925184741.GF5951@linux>
 <1443206945.2161.9.camel@sipsolutions.net>
Message-ID: <20150925185256.GG5951@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-09-15, 20:49, Johannes Berg wrote:
> Ok, then, but that means Rafael is completely wrong ...
> debugfs_create_bool() takes a *pointer* and it needs to be long-lived,
> it can't be on the stack. You also don't get a call when it changes.

Ahh, ofcourse. My bad as well...

I think we can change structure definition but will wait for Rafael's
comment before that.

-- 
viresh
