From: narkewoody@gmail.com (Woody Wu)
Date: Thu, 22 Nov 2012 09:19:53 +0000 (UTC)
Subject: Kernel panic - not syncing: Attempted to kill init!
Message-ID: <slrnkarrg7.av9.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

"Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b"

I got above message when I am porting 3.4.19 to a s3c2410 board.  I
traced the execution path is: kernel_init() -> init_post() ->
run_init_process("/sbin/init") -> kernel_execve().

And, in the last function kernel_execve, the call of do_execve sucessed.
Then I see a piece of assembly code follows which I cannot understand.

That means, the root file system, which is mtdblock3 in my case, is
mounted and /sbin/init was started to execute, then I got the panic
message.

Is that possible that this is caused by the root file system instead of
the kernel? The root file system is a very old one that can run with an
old kernel 2.6.14.


Do you have any clue?  Thanks in advance!

-- 
woody
I can't go back to yesterday - because I was a different person then.
