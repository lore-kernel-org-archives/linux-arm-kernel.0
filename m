From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 23 Jul 2013 11:33:55 +0100
Subject: OMAP2430 SDP boot broken after Linus' rmk merge
In-Reply-To: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
Message-ID: <51EE5C13.1000004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 22/07/13 19:07, Paul Walmsley wrote:
>
> Hi,
>
> After Linus's commit fb2af0020a51709ad87ea8055c325d3fbde04158 ("Merge
> branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm"), the
> OMAP2430 SDP here stopped booting.
>
> Here's the bootlog at the commit before the merge, commit 790eac5640:
>
> http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722015454/
>
> and here's a log at commit fb2af0020a5:
>
> http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722005921/
>
> Any ideas as to what might have caused this?
>

I've just had a quick go at booting 3.11-rc2 on an integrator-cp (1136) 
in the hope that we might be able to reproduce this on those boards, but 
I'm afraid the integrator works...

I took your config, modified it as little as possible to switch to 
Integrator and turn on earlyprintk, and then tried to boot. That *did* 
require switching away from ARCH_MULTIPLATFORM, so it isn't as similar 
as I'd like, though...

So I think we can at least say that this is not 1136 specific... Sorry 
not to be more helpful...

Jonny
