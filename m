From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Oct 2015 23:30:12 +0530
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007173934.GB10665@kroah.com>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux> <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux> <20151007171949.GB9702@kroah.com>
 <20151007172701.GF4557@linux> <20151007173934.GB10665@kroah.com>
Message-ID: <20151007180012.GH4557@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-10-15, 18:39, Greg Kroah-Hartman wrote:
> Why not?  Why does this have to be exported in debugfs?  Just delete it,
> who cares about it?  It's just "debugging".

It is really useful to see all the freq/voltage combinations on which
a device can work on, specially the CPU. And there are some serious
users of it as well..

Android has hacked the cpufreq layer today, to export something
similar in a hacky way, as they wanted to estimate power ratings based
on Hz/uV values. This will kill them as well..

And its really useful for debugging as well, to see if all went well.

Maybe debugfs is not really the best place for this, but yeah, this is
very useful.

-- 
viresh
