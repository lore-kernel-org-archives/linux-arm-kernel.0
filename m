From: narkewoody@gmail.com (Woody Wu)
Date: Mon, 26 Nov 2012 15:40:42 +0800
Subject: Kernel panic - not syncing: Attempted to kill init!
In-Reply-To: <CAPFyZi6VYWaMmb4WVZdDyv5yrz5MTvM8k6GkY_F=MsJNBU69JA@mail.gmail.com>
References: <slrnkarrg7.av9.narkewoody@zuhnb712.local.com>
 <CAPFyZi6VYWaMmb4WVZdDyv5yrz5MTvM8k6GkY_F=MsJNBU69JA@mail.gmail.com>
Message-ID: <20121126074042.GA4034@zuhnb712.ap.bm.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Jello

It's a little strange that your reply not appear on the list (at least
at this moment).

Firstly thank you so much for the suggestion.  But you know, this old
file system is working for a old 2.6 kernel, which was not built by me.
Hence I can see, this file system is okay for at least that version of
kernel.

For the situation, I want to try something from two directions:
1. Is there possible something missed from the kernel side? Any
suggestion?
2. Because it resulted in a kernel panic message, I have no good way to
trace it.  Can I run something else (init=) from the root file system to
gather more information about the file system?  So, how can I play with
the "init=" parameter to help for the case?

Thanks in advance.

-woody

On Thu, Nov 22, 2012 at 05:50:05PM +0800, Jello huang wrote:
> pls check u root file system.if the root file system is no filesystem or not
> * correct .the kernel shall*
> *throw the kernel panic*
> 
> 
> On 22 November 2012 17:19, Woody Wu <narkewoody@gmail.com> wrote:
> 
> > Hi,
> >
> > "Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b"
> >
> > I got above message when I am porting 3.4.19 to a s3c2410 board.  I
> > traced the execution path is: kernel_init() -> init_post() ->
> > run_init_process("/sbin/init") -> kernel_execve().
> >
> > And, in the last function kernel_execve, the call of do_execve sucessed.
> > Then I see a piece of assembly code follows which I cannot understand.
> >
> > That means, the root file system, which is mtdblock3 in my case, is
> > mounted and /sbin/init was started to execute, then I got the panic
> > message.
> >
> > Is that possible that this is caused by the root file system instead of
> > the kernel? The root file system is a very old one that can run with an
> > old kernel 2.6.14.
> >
> >
> > Do you have any clue?  Thanks in advance!
> >
> > --
> > woody
> > I can't go back to yesterday - because I was a different person then.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> 
> 
> -- 
> Thanks
> Jello Huang

-- 
woody
I can't go back to yesterday - because I was a different person then.
