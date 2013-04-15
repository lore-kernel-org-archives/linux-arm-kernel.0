From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 15 Apr 2013 12:48:33 +0100
Subject: [Xen-devel] [PATCH] arm64: remove PSR bit macros from uapi
In-Reply-To: <60a204007309b815b1ac115c817dc808@localhost>
References: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
 <20130412151835.GK12363@mudshark.cambridge.arm.com>
 <1365781834.15783.107.camel@zakaz.uk.xensource.com>
 <1365782789.15783.113.camel@zakaz.uk.xensource.com>
 <60a204007309b815b1ac115c817dc808@localhost>
Message-ID: <1366026513.4963.106.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-12 at 17:17 +0100, Marc Zyngier wrote:
> On Fri, 12 Apr 2013 17:06:29 +0100, Ian Campbell <Ian.Campbell@citrix.com>
> wrote:
> 
> [...]
> 
> > On the flip side is there any reason for the Linux uapi headers to be
> > including architectural constants? e.g. the x86 uapi/ptrace.h doesn't
> > define the RFLAGS bits etc...
> 
> My favourite userspace program (aka the other platform emulation that
> shall not ever be merged) needs it. QEMU probably will as well.
> 
> Of course, we could define them locally, but that seems like a massive
> waste of perfectly innocent bytes.

I appreciate it's convenient but I'm not sure there is a shortage of
bytes in the world, especially for well known unchanging constants like
this. Your favourite userspace program is a bit of a special case since
it doesn't need to be portable to non-Linux (or I assume not).

Anyway, ignoring the red-herring I introduced the main point isn't that
uapi/ptrace.h includes these definitions (that seems to be OK, standards
wise and is useful to you etc) but rather that they end up infecting
signal.h too. I'll file a bug against glibc/ubuntu/linaro as soon as I
figure out which is the best target...

>  or convince the power that be to merge
> the damned thing so we can include kernel headers with any remorse... ;-)

/me steps back several paces and puts away his barge pole. ;-)

Ian.
