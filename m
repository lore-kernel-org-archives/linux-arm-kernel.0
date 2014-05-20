From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 20 May 2014 12:31:12 +0100
Subject: [PATCH 0/4] arm64: simplify restrictions on bootloaders
In-Reply-To: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1400585472.6946.8.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-05-16 at 10:50 +0100, Mark Rutland wrote:
> Currently bootloaders have an extremely difficult time protecting memory from
> the kernel, as the kernel may clobber memory below TEXT_OFFSET with pagetables,
> and above the end of the kernel binary with the BSS.

I took a look through this partly with my Xen hat on (Xen effectively
contains a bootloader) and partly with my general noseybeak hat on and
it all looked pretty sensible to me. So I don't think this change will
cause any problems for Xen.

Cheers,
Ian.
