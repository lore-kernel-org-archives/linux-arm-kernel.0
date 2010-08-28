From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Sat, 28 Aug 2010 09:43:04 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <4C7867D4.10404@codeaurora.org>
References: <4C61EE55.5030506@codeaurora.org>
	<201008251414.16411.arnd@arndb.de>
	<20100825125451.GH2153@osiris.boeblingen.de.ibm.com>
	<201008251555.53653.arnd@arndb.de>
	<20100825144040.GI2153@osiris.boeblingen.de.ibm.com>
	<4C7867D4.10404@codeaurora.org>
Message-ID: <20100828074304.GA2183@osiris.boeblingen.de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 06:35:16PM -0700, Stephen Boyd wrote:
> On 08/25/2010 07:40 AM, Heiko Carstens wrote:
> > On Wed, Aug 25, 2010 at 03:55:53PM +0200, Arnd Bergmann wrote:
> >>
> >> If you don't want to see the warnings, then just remove the strict checks.
> >> We already concluded that there is little value in them on s390 since it only
> >> shows false postives.
> >>
> >> Maybe the easiest way would be to rename the option on s390 and move all
> >> the other ones into a common place.
> > 
> > Yes, feel free to do that.
> 
> Can you put up the false positives somewhere? I don't have easy access
> to an s390 toolchain to test build with and I'm interested to see how
> bad the false positives are.
> 
> I'm slightly concerned that we'll just have this problem again when
> another arch comes along with false positives. But ignoring that issue
> is probably fine. I'll respin with a patch to move s390 to something
> like DEBUG_WARN_USER_COPY_CHECKS.

Sure:

In function 'copy_from_user',
    inlined from 'write_enabled_file_bool' at kernel/kprobes.c:1973:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'perf_copy_attr' at kernel/perf_event.c:4988,
    inlined from 'SYSC_perf_event_open' at kernel/perf_event.c:5092,
    inlined from 'SyS_perf_event_open' at kernel/perf_event.c:5077:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from '__tun_chr_ioctl' at drivers/net/tun.c:1200:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:880:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1143:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1250:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1272:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1296:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1319:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1342:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1363:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1384:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1405:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1432:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_if_write' at net/core/pktgen.c:1468:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_thread_write' at net/core/pktgen.c:1792:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'pktgen_thread_write' at net/core/pktgen.c:1823:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'write_file_bool' at fs/debugfs/file.c:434:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'sg_proc_write_dressz' at drivers/scsi/sg.c:2396:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'sg_proc_write_adio' at drivers/scsi/sg.c:2373:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'packet_getsockopt' at net/packet/af_packet.c:2123:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
In function 'copy_from_user',
    inlined from 'compat_sys_socketcall' at net/compat.c:783:
/linux-2.6/arch/s390/include/asm/uaccess.h:297: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct
