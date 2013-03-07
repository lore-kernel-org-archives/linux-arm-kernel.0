From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 09:32:02 +0000
Subject: [PATCH] ARM: S3C24XX: drop "select MACH_N35"
In-Reply-To: <015001ce1ad1$185e66d0$491b3470$%kim@samsung.com>
References: <1362609234.28137.2.camel@x61.thuisdomein>
 <013a01ce1ac7$11b287d0$35179770$%kim@samsung.com>
 <1362615081.28137.5.camel@x61.thuisdomein>
 <014601ce1acd$bc63d480$352b7d80$%kim@samsung.com>
 <20130307005206.GZ17833@n2100.arm.linux.org.uk>
 <015001ce1ad1$185e66d0$491b3470$%kim@samsung.com>
Message-ID: <20130307093202.GC17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:14:19AM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > And deleting entries from it is pointless if they've ever been in the
> > kernel.
> 
> OK, I see and agree.

The issue is that the database system "locks" an entry into the file as
soon as support is merged into mainline for the platform.  The reason
for this is that as soon as the support gets merged into a kernel verison,
that symbol is then referenced.

If anyone goes to the website to download a new copy of the file, it then
must continue to contain that symbol because they may be using the file
with any kernel version - maybe a version of the kernel with your platform
support in - and maybe they're using something that references the
generated ID/macros from your entry.

Updates to the file in the mainline kernel are merely re-downloads of the
file from the website and committed.

So, deleting entries once used in mainline is extremely problematical.  If
someone commits such a patch, my next update from the website/database to
the file will put it back.  Hence the problem.
