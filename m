From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Jul 2018 13:10:37 +0200
Subject: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
In-Reply-To: <20180709103305.GF112168@atomide.com>
References: <20180708174939.GA10002@amd> <20180708193720.GA13262@amd>
 <20180709103305.GF112168@atomide.com>
Message-ID: <20180709111036.GB11785@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-07-09 03:33:05, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180708 19:40]:
> > Ok, so it seems to be:
> > 
> > user at devuan:~$ cat /sys/kernel/debug/pm_debug/count
> > (oops).
> > 
> > The file seems to be world-readable.
> > 
> > user at devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> > -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> > 
> > But on PC, that file does not exist.
> > 
> > Any ideas?
> 
> I'm not seeing this as tested with omap2plus_defconfig and
> not seeing any unclocked module interrupts here.. Can you
> see if the script below produces something for you?
> 
> I had to filter out some trace pipes as they seem to hang.

After some more debugging:

+       printk("3...\n");
        cm_per_dump(s);
+       printk("4...\n");

cm_per_dump seems to be the problem.
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/3cbd8614/attachment.sig>
