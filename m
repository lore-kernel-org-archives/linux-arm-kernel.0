From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 8 Oct 2015 10:25:56 -0400 (EDT)
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151008074828.GF4570@linux>
Message-ID: <Pine.LNX.4.44L0.1510081023080.1502-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Oct 2015, Viresh Kumar wrote:

> > In my patch, I assumed that if 32-bit architectures work fine today, then
> > we don't need more range on 64-bit architectures either.
> 
> The problem here is that we haven't fixed it properly.
> - clock framework expects it to be unsigned long
> - DT is sending a 64 bit value in Hz
> - But we are storing and exposing it in u32
> 
> That's weird, isn't it?
> 
> So, either we update clock API and other similar APIs to u64 or u32
> (which may not be the right thing to do), Or we keep it unsigned long
> here as well and add debugfs_create_ulong().

I don't see why debugfs can't accomodate C's builtin types, rather than 
insisting on predetermined sizes.  After, the printf family of 
functions does that: %u vs. %lu.  In fact, there's no way to tell 
printf that a particular value is 32 bits or 64 bits.

Alan Stern
