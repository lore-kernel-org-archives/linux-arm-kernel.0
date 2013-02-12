From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 17:42:54 -0800
Subject: [PATCH 03/19] ARM: msm: proc_comm_boot_wait should not be __init
In-Reply-To: <8yak3r15ds0.fsf@huya.qualcomm.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-4-git-send-email-arnd@arndb.de>
 <8yak3r15ds0.fsf@huya.qualcomm.com>
Message-ID: <20130212014254.GA6952@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 10:16:31AM -0800, David Brown wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > msm_smd_probe is a driver probe function and may get
> > called after the __init time, so it must not call
> > any __init function, as the link-time warning reports.
> > Take away the __init annotation on proc_comm_boot_wait
> > to fix this.
> >
> > Without this patch, building msm_defconfig results in:
> >
> > WARNING: vmlinux.o(.text+0xb048): Section mismatch in reference from the function msm_smd_probe() to the function .init.text:proc_comm_boot_wait()
> > The function msm_smd_probe() references
> > the function __init proc_comm_boot_wait().
> > This is often because msm_smd_probe lacks a __init
> > annotation or the annotation of proc_comm_boot_wait is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: David Brown <davidb@codeaurora.org>
> > Cc: Bryan Huntsman <bryanh@codeaurora.org>
> > Cc: Daniel Walker <c_dwalke@quicinc.com>
> > Cc: linux-arm-msm at vger.kernel.org
> > ---
> >  arch/arm/mach-msm/proc_comm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Arnd, you're welcome to pull this into your tree:
> Acked-by: David Brown <davidb@codeaurora.org>
> 
> I don't forsee any conflicts with upcoming patches.

Applied.


-Olof
