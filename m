From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Oct 2015 18:33:24 +0530
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007125735.GA8170@kroah.com>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux> <20151007125735.GA8170@kroah.com>
Message-ID: <20151007130324.GA4557@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Mike and Stephen..

On 07-10-15, 13:57, Greg Kroah-Hartman wrote:
> On Wed, Oct 07, 2015 at 04:51:49PM +0530, Viresh Kumar wrote:
> > On 07-10-15, 12:07, Greg Kroah-Hartman wrote:
> > > Why would you be wanting to create a "unsigned long" as an api anyway?
> > > Just force it to be u64 all the time, can't you do that?
> > 
> > Okay, so the variable in question (lets say frequency) is an 'unsigned
> > long' and that's how all the APIs of clock framework expect/define
> > it.
> > 
> > And you are probably saying that we do this:
> > 
> > unsigned long freq;
> > 
> > debugfs_create_u64((u64 *)&freq);
> > 
> > Right? Or are you asking to update clock APIs to be converted to u64?
> 
> Yes, they should be u64 as I doubt you want to debug problems that you
> have in the driver where it works on a 64bit system but doesn't on a
> 32bit one.

Firstly changing the clock API (and other similar APIs) to make
frequency u64 instead of 'unsigned long', looks like a giant effort.
There are too many users of those API, etc..

Over that, it might be good performance wise to use u32 for 32 bit
systems and u64 for 64 bit one, to represent clock frequency and maybe
that's why we chose unsigned long there.

-- 
viresh
