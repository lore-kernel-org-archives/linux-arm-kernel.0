From: rabin@rab.in (Rabin Vincent)
Date: Thu, 16 Dec 2010 20:42:23 +0530
Subject: [PATCH] ARM: ensure all sched_clock() implementations are notrace
	marked
In-Reply-To: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 1:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> ftrace requires sched_clock() to be notrace. ?Ensure that all
> implementations are so marked.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

It does seem better to have all of them explicity annotated anyway, even
if it not required in most of the cases because they include
<linux/sched.h> and the annotation in the declaration takes effect.

Note that in order for this to be fully effective, all functions called
from sched_clock() need to be notrace too.  OMAP and u300 miss this.
The following patches fix them up; perhaps you can fold them into this
one.  If not, I will rebase them later after this series is merged:

http://www.spinics.net/lists/arm-kernel/msg104616.html
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38911.html
