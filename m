From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 18:17:01 +0200
Subject: [Xen-devel] [PATCH] arm64: remove PSR bit macros from uapi
In-Reply-To: <1365782789.15783.113.camel@zakaz.uk.xensource.com>
References: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
 <20130412151835.GK12363@mudshark.cambridge.arm.com>
 <1365781834.15783.107.camel@zakaz.uk.xensource.com>
 <1365782789.15783.113.camel@zakaz.uk.xensource.com>
Message-ID: <60a204007309b815b1ac115c817dc808@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Apr 2013 17:06:29 +0100, Ian Campbell <Ian.Campbell@citrix.com>
wrote:

[...]

> On the flip side is there any reason for the Linux uapi headers to be
> including architectural constants? e.g. the x86 uapi/ptrace.h doesn't
> define the RFLAGS bits etc...

My favourite userspace program (aka the other platform emulation that
shall not ever be merged) needs it. QEMU probably will as well.

Of course, we could define them locally, but that seems like a massive
waste of perfectly innocent bytes. or convince the power that be to merge
the damned thing so we can include kernel headers with any remorse... ;-)

        M.
-- 
Fast, cheap, reliable. Pick two.
