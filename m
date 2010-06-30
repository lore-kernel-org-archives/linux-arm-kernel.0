From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 16:17:46 +0200
Subject: Flash write endurance (write cycle) test for AT91RM9200 boards
In-Reply-To: <BAY134-W19D664FC2A596F0209D21FBDCA0@phx.gbl>
References: <BAY134-W19D664FC2A596F0209D21FBDCA0@phx.gbl>
Message-ID: <201006301617.46700.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 28. ?ervna 2010 22:39:07 Xiachen Dong napsal(a):
> Hi,
> 
> We use AT91RM9200 MCU and made our own motherboard for it. We wish to know
> how many write cycles the flash (MicroSD and DataFlash) may survive under
> both OS and non-OS situation. We also wish to know the behavior of the
> flash when the flash becomes dead.

I believe the number of write cycles is unlimited, but at some point, you won't 
be able to read the data back ;-) If the flash becomes dead, kernel will mark a 
bad block and that's all (you'll be informed). Writes to this block will be 
redirected to some healthy block. You'll probably have the flash partitioned and 
run some FS on top of it, which will take care of load balancing the flash 
blocks. You don't have to worry that the flash will die fast if you don't swap 
on it.

Cheers 
> 
> After doing some searching on the web, we found the following information
> helpful:
> 
> 1) Write Endurance in Flash Drives: Measurements and Analysis
> http://www.ccs.neu.edu/home/pjd/papers/fast10-flash.pdf
> 
> 2) NAND Testing
> http://wiki.laptop.org/go/NAND_Testing
> 
> 3) How Long Does a Flash Drive Last?
> http://www.bress.net/blog/archives/114-How-Long-Does-a-Flash-Drive-Last.htm
> l
> 
> What we plan to do is to test the flash both under u-boot (raw, without
> JFFS2) and Linux OS (with ext2 fs). The test will be done with flash empty
> and flash full. We will also do the test under different room
> temperatures.
> 
> We searched the archive of the list. It looks like no posts mentioned such
> tests. We wonder anyone on the list has done similar test before and are
> there any special attention need to pay while doing such tests. Are there
> any professional software (either open source or commercial) for such
> tests? Any suggestions and comments are welcomed.
> 
> Thanks,
> 
> Xiachen
> 
> 
> _________________________________________________________________
> Turn down-time into play-time with Messenger games
> http://go.microsoft.com/?linkid=9734385
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
