From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 25 Sep 2015 22:22:33 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1460975.zriLPuubXp@vostro.rjw.lan>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1460975.zriLPuubXp@vostro.rjw.lan>
Message-ID: <16046206.NvsuxYn5NN@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 25, 2015 10:18:13 PM Rafael J. Wysocki wrote:
> On Friday, September 25, 2015 09:41:37 AM Viresh Kumar wrote:
> > global_lock is defined as an unsigned long and accessing only its lower
> > 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> > for big endian 64 bit systems. There are no such platforms yet, but the
> > code needs to be robust for such a case.
> > 
> > Fix that by passing a local variable to debugfs_create_bool() and
> > assigning its value to global_lock later.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Greg, please take this one if the [2/2] looks good to you.

Ouch, turns out it was a bad idea.  Please scratch that.

Thanks,
Rafael
