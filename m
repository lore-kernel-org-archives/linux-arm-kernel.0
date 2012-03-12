From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 12 Mar 2012 16:03:09 -0400
Subject: ARM926EJS boot failure on v3.3, __iounmap
Message-ID: <CAKON4OzL9HtF+3bxzC9zexd7QgAFd5R7Wr=QTShYR+Kk1b4L+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on getting out of tree support for the NXP LPC31xx
ARM926EJS based CPUs ready for submission. Everything was working fine
on v3.2 but I lost the ability to boot with v3.3. The boot failure is
very early in the boot process. I did a bisect and came up with:

[6ee723a6570a897208b76ab3e9a495e9106b2f8c] ARM: simplify __iounmap()
when dealing with section based mapping

I tried to revert it but there have been a bunch of edits in this
file. Not sure how to go about debugging this.

-- 
Jon Smirl
jonsmirl at gmail.com
