From: yesskarthik@gmail.com (Karthik Srinivasamurthy)
Date: Wed, 29 Nov 2017 18:45:53 -0800
Subject: setting RO permissions for kernel text does not work when XN bit is
 set for the section before _stext
Message-ID: <CAEe49tyB00+-7o1K4z9CpR8vn1SyoUDAPbDwX5o1siWqJyjxyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am on kernel 3.12.19 on a cortex A7 quad core SOC. I integrated
Laura's patch to set the kernel text RO, but i couldn't get it  to
work and i see something strange.
While experimenting, i cleared the XN bit for the 1MB section before
the _stext, which has the page tables etc, prior to setting RO perms
on the text area. Then i see the kernel panic with permission fault
80d, every time i try corrupting the text space. If i don't clear the
XN bit
on the section preceding the _stext, then it lets me corrupt the text
section happily.
I am confused as to what the co-relation is? any help in clarifying is
much appreciated.


Thanks
Karthik
