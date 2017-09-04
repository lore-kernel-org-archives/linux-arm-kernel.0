From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 4 Sep 2017 11:15:47 +0200
Subject: [PATCH V3 1/8] drivers: Add boot constraints core
In-Reply-To: <20170829120343.GA4321@kroah.com>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <1a844e27ee7e0b22acf8ea582bf4e8d35f54c84a.1501578037.git.viresh.kumar@linaro.org>
 <20170829063923.GD12198@kroah.com> <20170829095217.GA3101@ubuntu>
 <20170829120343.GA4321@kroah.com>
Message-ID: <20170904091522.GA2816@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-08-17, 14:03, Greg Kroah-Hartman wrote:
> Who couldn't reach an agreement?

Rob Herring (DT Maintainer) didn't like the first set of bindings and wasn't
convinced that we need any new bindings for this purpose to begin with.

> So you gave up and decided to make a
> whole bunch of kernel code instead of just using new DT entries?  That's
> crazy...

Its not a lot really. Most of the code is anyways required, the only extra part
is the platform specific drivers, which are replacing what the DT would have
done. So, it shouldn't be that big of a deal I suppose.

> Let's see a working system or two first here please.

Sure, I will get as many converted as possible.

> But you are implying that existing handheld devices need this problem
> solved, how do they do it today without this code as obviously they are
> shipping working solutions.

So yeah, LCD is a common usecase but the configurations aren't always shared. It
may not be an issue with private clock/regulator resources, but with shared
ones.

Though even with the private resources, we may want the clock/domains/regulators
to stay powered on and I assume that the platforms would be doing hacky stuff to
get that all working right now.

-- 
viresh
