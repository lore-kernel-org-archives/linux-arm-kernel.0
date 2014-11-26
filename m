From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 26 Nov 2014 16:22:00 +0100
Subject: n900: kernel cmdline from bootloader in DT mode
In-Reply-To: <201411261436.42166@pali>
References: <201411261354.33652@pali> <20141126132800.GA27610@amd>
 <201411261436.42166@pali>
Message-ID: <20141126152159.GA26123@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-11-26 14:36:42, Pali Roh?r wrote:
> On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> > Hi!
> > 
> > > for some unknown reasons when I compile kernel for n900 in
> > > DT mode it ignore cmdline passed by bootloader. When I
> > > comment
> > > 
> > > CONFIG_ARM_APPENDED_DTB=y
> > > 
> > > then it boots into legacy board mode and cmdline is used
> > > from bootloader.
> > > 
> > > When is problem?
> > 
> > It seems to work for me, I'm booting using 0xffff, with
> > attached config.
> > 									Pavel
> 
> Can you try to set some "root=something" into CONFIG_CMDLINE and 
> then add real "root=" param via 0xffff?
> 
> My problem is that I have specified ubifs mtd root in 
> CONFIG_CMDLINE and when I set correct root via bootloader (from 
> 0xffff or flasher-3.5) it is ignored and used only what is 
> specified in CONFIG_CMDLINE.

CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set                                             
CONFIG_CMDLINE="console=ttyO2,115200 console=tty"

Um.. Internal commandline should be completely ignored for me.

Do you have CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
