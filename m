From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 14 Aug 2014 15:56:02 -0500
Subject: socfpga mmc (was Re: [GIT PULL] SOCFPGA DTS updates for 3.17)
In-Reply-To: <20140814184710.GA11558@amd.pavel.ucw.cz>
References: <1405397216-909-1-git-send-email-dinguyen@altera.com>
 <53C4D874.2040206@samsung.com> <20140814184710.GA11558@amd.pavel.ucw.cz>
Message-ID: <53ED2262.50604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/14/14, 1:47 PM, Pavel Machek wrote:
> Hi!
> 
> I tried booting kernel based on ba36899, and got:
> 
> mmc0: new SDHC card at address b368                                             
> mmcblk0: mmc0:b368 USD   7.45 GiB                                               
>  mmcblk0: p1 p2 p3 p4                                                           
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error
> -6        
> Please append a correct "root=" boot option; here are the available
> partitions: 
> b300         7822336 mmcblk0  driver: mmcblk                                    
>   b301          102400 mmcblk0p1 00082434-01                                    
>   b302         1048576 mmcblk0p2 00082434-02                                    
>   b303            1024 mmcblk0p3 00082434-03                                    
>   b304         6086656 mmcblk0p4 00082434-04                                    
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)  
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.16.0-11208-gef74117-dirty
> #2        

Hmm...today's tip-top(899552d6) and ba36899 booted just fine for me. I
noticed something, you must have commits on top of your ba36899? Mine
shows 3.16.0-11149-gba36899.

But just a thought, should one really be developing and debugging with
commits in a merge window?

Dinh
> 
> IIRC it worked ok in 3.16 in similar config. It may be stupid mistake,
> but if you know what I did wrong, I'd like to know... (-6 is ENXIO, so
> -- how can the device be there and not be there at the same time?)
> 
> 									Pavel
> 
