From: ruifeihuang@gmail.com (Jello huang)
Date: Thu, 22 Nov 2012 17:50:05 +0800
Subject: Kernel panic - not syncing: Attempted to kill init!
In-Reply-To: <slrnkarrg7.av9.narkewoody@zuhnb712.local.com>
References: <slrnkarrg7.av9.narkewoody@zuhnb712.local.com>
Message-ID: <CAPFyZi6VYWaMmb4WVZdDyv5yrz5MTvM8k6GkY_F=MsJNBU69JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pls check u root file system.if the root file system is no filesystem or not
* correct .the kernel shall*
*throw the kernel panic*


On 22 November 2012 17:19, Woody Wu <narkewoody@gmail.com> wrote:

> Hi,
>
> "Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b"
>
> I got above message when I am porting 3.4.19 to a s3c2410 board.  I
> traced the execution path is: kernel_init() -> init_post() ->
> run_init_process("/sbin/init") -> kernel_execve().
>
> And, in the last function kernel_execve, the call of do_execve sucessed.
> Then I see a piece of assembly code follows which I cannot understand.
>
> That means, the root file system, which is mtdblock3 in my case, is
> mounted and /sbin/init was started to execute, then I got the panic
> message.
>
> Is that possible that this is caused by the root file system instead of
> the kernel? The root file system is a very old one that can run with an
> old kernel 2.6.14.
>
>
> Do you have any clue?  Thanks in advance!
>
> --
> woody
> I can't go back to yesterday - because I was a different person then.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Thanks
Jello Huang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/8a7a7802/attachment.html>
