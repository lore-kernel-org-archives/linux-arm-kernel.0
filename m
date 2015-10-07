From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 7 Oct 2015 12:07:55 +0100
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007110302.GD9892@linux>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
Message-ID: <20151007110755.GA6601@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 04:33:02PM +0530, Viresh Kumar wrote:
> On 07-10-15, 16:29, Viresh Kumar wrote:
> > What about adding something like debugfs_create_unsigned_long() for
> > such cases?
> 
> And that can be as simple (or ugly, not sure if its buggy) as:
> 
> debugfs_create_unsigned_long()
> {
>         if (sizeof(unsigned long) == sizeof(u32))
>                 return debugfs_create_u32();
>         if (sizeof(unsigned long) == sizeof(u64))
>                 return debugfs_create_u64();
> 
>         return -EINVAL;
> }

Why would you be wanting to create a "unsigned long" as an api anyway?
Just force it to be u64 all the time, can't you do that?

thanks,

greg k-h
