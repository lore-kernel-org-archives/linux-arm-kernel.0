From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jul 2011 23:37:15 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <alpine.LFD.2.00.1107081327190.14596@xanadu.home>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<20110708162718.GI4812@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107081327190.14596@xanadu.home>
Message-ID: <201107082337.15584.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 July 2011 20:09:29 Nicolas Pitre wrote:
> Indeed.  The VMALLOC_END case is possibly different as we were trying to 
> find a way to adjust it automatically at run time which would be one 
> thing less for platforms to care about.  Having a globally fixed value 
> for it would also solve the multiple definition problem.  But some 
> machines have a large set of IO mappings while some others have a 
> small one, so having a one size fits all solution here might be 
> suboptimal.

Is everything between VMALLOC_END and 0xfeffffff guaranteed to come
from iotable_init? If so, we could perhaps turn it into a variable
that gets initialized to 0xfeffffff and decreased by iotable_init
to be just below the lowest address that has actually been mapped.

Obviously, anything that derives values from VMALLOC_END at compile
time would need to change, too.

	Arnd
