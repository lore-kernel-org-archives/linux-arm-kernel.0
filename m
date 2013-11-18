From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 13:54:39 +0000
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <CACxGe6sgRwiakJLUCtaaQ2NF51PpkoNZvZr6EoE-BPeZiDsDFQ@mail.gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
 <5283DB34.9050301@gmail.com> <201311141332.58498.arnd@arndb.de>
 <CACxGe6uMWjfmB4WDKs+vu05224jqpbDZBHT_ZXnqxw17JzUqvw@mail.gmail.com>
 <5284E236.1000606@gmail.com>
 <CACxGe6sgRwiakJLUCtaaQ2NF51PpkoNZvZr6EoE-BPeZiDsDFQ@mail.gmail.com>
Message-ID: <20131118135439.GC16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:16:29AM +0900, Grant Likely wrote:
> On Thu, Nov 14, 2013 at 11:46 PM, Rob Herring <robherring2@gmail.com> wrote:
> > If this is a required feature then we should make machine_desc common
> > (or at least part of it) with the other arches that have copied arm and
> > then add it to arm64 as well. Then I could do further consolidation of
> > the FDT machine matching code. Otherwise this is all just pointless
> > architecture variation that really has nothing to do with the architecture.
> 
> I think you are missing my point. go ahead, take it out of
> /proc/cpuinfo. That's not the issue.

You do realise this is a user API issue, right?

http://fossies.org/dox/glibc-2.18/ports_2sysdeps_2unix_2sysv_2linux_2arm_2ioperm_8c_source.html

Right, it only has four strings which it matches against, but this is
evidence that /proc/cpuinfo is a user API, and the strings therein are
used by userspace in ways you don't expect.

We can't just go around removing things.
