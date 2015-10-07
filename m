From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 7 Oct 2015 13:57:35 +0100
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007112149.GB22530@linux>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
Message-ID: <20151007125735.GA8170@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 04:51:49PM +0530, Viresh Kumar wrote:
> On 07-10-15, 12:07, Greg Kroah-Hartman wrote:
> > Why would you be wanting to create a "unsigned long" as an api anyway?
> > Just force it to be u64 all the time, can't you do that?
> 
> Okay, so the variable in question (lets say frequency) is an 'unsigned
> long' and that's how all the APIs of clock framework expect/define
> it.
> 
> And you are probably saying that we do this:
> 
> unsigned long freq;
> 
> debugfs_create_u64((u64 *)&freq);
> 
> Right? Or are you asking to update clock APIs to be converted to u64?

Yes, they should be u64 as I doubt you want to debug problems that you
have in the driver where it works on a 64bit system but doesn't on a
32bit one.

thanks,

greg k-h
