From: sakoman@gmail.com (Steve Sakoman)
Date: Thu, 6 Oct 2011 14:22:23 -0700
Subject: [PATCH v2] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
	control detection
In-Reply-To: <alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
	<alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
Message-ID: <CAGDS+nmb20E4y2HqBtDN05PK1C1YXjmRvnVAbQkhGpp17s4Zcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 6, 2011 at 12:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The way that we detect which OMAP3 chips support I/O wakeup and
> software I/O chain clock control is broken.
>
> Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
> than the AM3505/3517. ?The TI81xx family of SoCs are at present
> considered to be OMAP3 SoCs, but don't support I/O wakeup. ?To resolve
> this, convert the existing blacklist approach to an explicit,
> whitelist support, in which only SoCs which are known to support I/O
> wakeup are listed. ?(At present, this only includes OMAP34xx,
> OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)
>
> Also, the current code incorrectly detects the presence of a
> software-controllable I/O chain clock on several chips that don't
> support it. ?This results in writes to reserved bitfields, unnecessary
> delays, and console messages on kernels running on those chips:
>
> ? ?http://www.spinics.net/lists/linux-omap/msg58735.html
>
> Convert this test to a feature test with a chip-by-chip whitelist.
>
> Thanks to Dave Hylands <dhylands@gmail.com> for reporting this problem
> and doing some testing to help isolate the cause. ?Thanks to Steve
> Sakoman <sakoman@gmail.com> for catching a bug in the first version of
> this patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>

I just tested a Linux 3.0 version of the patch on both ES2.1
and ES3.1 and it works just fine.

So here is my:

Tested-by: Steve Sakoman <steve@sakoman.com>
