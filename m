From: pthomas8589@gmail.com (Paul Thomas)
Date: Thu, 28 Jan 2010 21:40:15 -0700
Subject: at91san9g20, INFO: RCU detected CPU 0 stall
Message-ID: <c785bba31001282040o65a9dd30mebeeb72631936c95@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm getting the following errors on the console:
INFO: RCU detected CPU 0 stall (t=1000 jiffies)
INFO: RCU detected CPU 0 stall (t=4000 jiffies)
INFO: RCU detected CPU 0 stall (t=7000 jiffies)
...

The system is mostly unresponsive at this point. The console & ssh are
unresponsive, but ping still works (Is that just the PHY responding?).

I'm pretty sure this is because I enabled NO_HZ, HIGH_RES_TIMERS,
CONFIG_PREEMPT & ATMEL_TCLIB in the kernel. I've attached the .config file.
I'm using 2.6.33-rc2 without the maxim.org.za patch, and one minor
socket-can patch. I'm been using various versions of this same kernel for
weeks without any problems, and just today I wanted to use the high res
timers so I enabled that stuff in the kernel. I'm using the at91sam9g20
processor. I don't think it matters, but the command that triggered this was
"svn --version". After a reboot the "svn --version" command is fine.

What does this error/info mean? How is it different from a kernel panic?
Have other people seen this on the at91 devices?

thanks,
Paul
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100128/e7f2f2ed/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 33497 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100128/e7f2f2ed/attachment-0001.obj>
