From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Dec 2009 21:25:12 +0800
Subject: [PATCH] [ARM] pxa/cm-x300: fix build breakage caused by missing
	'select CPU_PXA310'
In-Reply-To: <20091215172326.GC15855@n2100.arm.linux.org.uk>
References: <4B27B92B.9020306@compulab.co.il>
	<20091215172326.GC15855@n2100.arm.linux.org.uk>
Message-ID: <f17812d70912160525n22e50f5dm3963197b3fc203e8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 1:23 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 15, 2009 at 06:28:27PM +0200, Mike Rapoport wrote:
>> Eric,
>> Apparently Igor's patches for CM-X300 were not applied properly. Somehow
>> commit db205463fd24c0972ad2c4e4fafb1c76e51b4380
>> ([ARM] pxa/cm-x300: add PWM backlight support) introduced 'select HAVE_PWM'
>> to MACH_COLIBRY300 rather than CM-X300. I suspect that the same happened with
>> the patch that added 'select CPU_PXA310' to MACH_CM_X300. I'm not certain about
>> removing PWM support in Colibri, but MACH_CM_X300 need to get fixed.
>
> You need to look at the original commit you mention above, and check
> whether it has been applied correctly. ?If not, it needs to be reverted
> and the correct change applied.
>
> This is one of the problems of patching Kconfig files that grow over
> time - diff only gives at most six lines of context (three lines either
> side), and it is possible to have those same six lines of context
> repeated several times in Kconfig files. ?Now add an additional set of
> lines towards the start of the Kconfig file, and such a diff will get
> incorrectly applied.
>
> Unfortunately, this is one of the down sides to using git apply over
> GNU patch - GNU patch will tell you if it applied a patch with an offset.
> git tools won't, so it's not obvious if a patch has been mis-applied.
>

It looks like Igor's original version is already wrong - must be due to
rebasing against my branch, esp. the commit of re-ordering Kconfig
and Makefile. But nothing to worry - I've reverted that commit and
made another commit including this change. Will push out later soon.
