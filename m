From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 16:36:50 +0000
Subject: [PATCH] mach_omap2: use PTR_RET instead of IS_ERR + PTR_ERR
In-Reply-To: <5149FFDF.6050501@ti.com>
References: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com>
 <20130312110557.GF30923@n2100.arm.linux.org.uk> <5149FFDF.6050501@ti.com>
Message-ID: <20130322163650.GN30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 01:28:47PM -0500, Jon Hunter wrote:
> Sorry I am now not sure I follow you here. Someone just pointed out to
> me that PTR_RET() is defined as ...
> 
> static inline int __must_check PTR_RET(const void *ptr)
> {
> 	if (IS_ERR(ptr))
> 		return PTR_ERR(ptr);
> 	else
> 		return 0;
> }
> 
> So the above change appears to be equivalent. Is there something that is
> wrong with the current implementation that needs to be fixed?

No - I misread it as PTR_ERR not PTR_RET.  Your patch is fine.
