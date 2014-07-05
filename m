From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 05 Jul 2014 13:05:55 +0200
Subject: [PATCH 00/19] ARM: SAMSUNG: S5PV210 platform clean-up
In-Reply-To: <53B7DADB.5080700@gmail.com>
References: <1404495893-26371-1-git-send-email-t.figa@samsung.com>
 <CAOh2x==dHrJkKw4h7y2nwYgFCv6s5ndU2DMiga302tzDaiaBWA@mail.gmail.com>
 <53B7DADB.5080700@gmail.com>
Message-ID: <22658676.rUbtH0jtbK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 5. Juli 2014, 13:00:43 schrieb Tomasz Figa:
> On 05.07.2014 06:46, Viresh Kumar wrote:
> > On Fri, Jul 4, 2014 at 11:14 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> >> This huge series is a (hopefully final) attempt to convert Samsung
> >> S5PV210
> >> into a DT-only and multiplatform-aware platform. It consists of several
> >> steps to gradually replace legacy code with one meeting current standards
> >> and then finally remove unused remnants.
> >> 
> >> Patches 1-6 migrate the platform to fully use the Common Clock Framework
> >> and get rid of legacy private clock code, of which s5pv210 was the last
> >> user. Then patch 7 adds generic PHY driver for USB PHY on S5PV210 to
> >> allow
> >> USB to be supported when using DT. Further three patches (8-10) add DT
> >> support for mach-s5pv210 and necessary DT sources for currently supported
> >> boards. Patch 11 removes board files and code directly related to them,
> >> effectively making s5pv210 a DT-only platform. In next step, patches
> >> 12-15
> >> prepare remaining code for multiplatform enablement, which is finally
> >> done
> >> in patch 16. Patches 17-19 are a final clean-up, which remove a lot of
> >> unused code left after making the last S5P platform DT-only.
> >> 
> >> Build tested patch by patch on following configs:
> >>  - s3c2410_defconfig (with DT support enabled),
> >>  - s3c6400_defconfig (with DT support enabled),
> >>  - s5pv210_defconfig (with DT support enabled after patches adding it),
> >>  - exynos_defconfig,
> >>  - exynos_defconfig with S5PV210 enabled in multiplatform configuration.
> >> 
> >> Boot tested on s5pv210-goni board.
> >> 
> >> Note that support for smdkc110, smdkv210 and torbreck boards is provided
> >> by moving data from existing board files to new device tree sources. No
> >> testing was performed due to mentioned board not being available anymore.
> >> However I believe we agreed on this approach, because apparently there
> >> are no active users of them. See the RFC from August 2013 asking for
> >> removal of the whole platform [1].
> >> 
> >> [1]
> >> http://www.mail-archive.com/linux-samsung-soc%40vger.kernel.org/msg21882
> >> .html>> 
> >> Tomasz Figa (13):
> >>   cpufreq: s3c24xx: Remove some dead code
> >>   cpufreq: s5pv210: Make the driver multiplatform aware
> > 
> > Looks like you used --suppress-cc=all while sending these and none of
> > CPUFreq/PM guys received it :(
> 
> Oops, I had a feeling that I has screwed up something with this series
> and now we know what. Sorry for this. Will resend properly next Tuesday.

I got the cover-letter 3 times (19:44, 19:46 and 19:48). The one from 19:48 
also did contain all 19 patches ;-)


Heiko
