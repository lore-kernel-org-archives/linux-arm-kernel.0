From: jbastian@redhat.com (Jeffrey Bastian)
Date: Tue, 21 Nov 2017 12:03:19 -0600
Subject: [PATCH v4 10/12] arm64: vdso: replace gettimeofday.S with global
 vgettimeofday.C
In-Reply-To: <61EF90BA-9A6D-4DC4-A1F4-BEAA210D708C@redhat.com>
References: <20171031183306.81375-1-salyzyn@android.com>
 <7775cc5e-4a24-1e33-aae5-6181ca018d80@android.com>
 <61EF90BA-9A6D-4DC4-A1F4-BEAA210D708C@redhat.com>
Message-ID: <20171121180319.tawkc42jjx4ow3hg@tarantula.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 12:22:36AM -0400, Jon Masters wrote:
> On Nov 2, 2017, at 06:14, Mark Salyzyn <salyzyn@android.com> wrote:
> > Holding off respin or followup patch until after we get a response
> > from Jon Masters <jcm@readhat.com> on their QE tests on this patch
> > series.
> 
> Copying Jeff Bastian who owns QE. Jeff, can you recall what test was
> failing when we tried the gettimeofday C rewrite VDSO patches?

The LTP clock_getres01 test was failing when we tried the initial
implementation of gettimeofday-in-C.  This would be a good place to
start when testing the new version of the patches.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_getres/clock_getres01.c


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat
