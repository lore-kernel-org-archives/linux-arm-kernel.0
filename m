From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 May 2012 20:51:09 -0400
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <1338401183.22894.11.camel@hactar>
References: <1338401183.22894.11.camel@hactar>
Message-ID: <20120531005109.GW24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 03:06:23PM -0300, Thiago Jung Bauermann wrote:
> Hello,
> 
> I have just upgraded my Dreamplug to the 3.4 kernel, and when creating
> an LVM snapshot volume, I see errors for which I didn't find any report
> yet:
> 
> # lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   Logical volume "root-fsck-snapshot" created
> 
> # lvremove -f marv2-vg/root-fsck-snapshot
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
>   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
>   Logical volume "root-fsck-snapshot" successfully removed
> 
> This is on the following kernel:
> 
> Linux marv 3.4.0-1bauer2-kirkwood #1 Wed May 30 01:31:47 BRT 2012 armv5tel GNU/Linux

Is this a vanilla v3.4 kernel?  Is this a repeatable error, even after
hard reboot?

thx,

Jason.
