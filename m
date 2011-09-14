From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Sep 2011 09:37:59 +0800
Subject: [PATCH 0/3] ARCH: CSR: basic PM suspend/resume support
In-Reply-To: <201109131811.28241.arnd@arndb.de>
References: <1315908393-362-1-git-send-email-Baohua.Song@csr.com>
	<201109131811.28241.arnd@arndb.de>
Message-ID: <CAGsJ_4y4YB6kw3Zo03vxN6OZQCtvAGDpiHQ8GjRu2RhPxWa60Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Thanks!

2011/9/14 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 13 September 2011, Barry Song wrote:
>>
>> it was in thread "ARM: CSR: add rtciobrg and PM support" before. See:
>> http://www.spinics.net/lists/arm-kernel/msg137375.html
>>
>> Arnd has pulled rtciobrg into arm-soc next branch. PM should be another
>> series.
>
> Looks good to me, feel free to add my Acked-by to the patches, but
> please add a meaningful changelog text to each patch first.
> You can use some of the text that you put in the introductory mail.
>

ok. i will. and thanks.

> In general, I expect even trivial patches to have a changelog of
> one sentence and more text if the patch touches more code.

make sense.

>
> If nobody has other comments on the code, please send me a pull
> request once that is done.

a problem is patch 3/3 depends on Shawn Guo <shawn.guo@linaro.org>'s
[PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
initialization functions
http://www.spinics.net/lists/arm-kernel/msg139198.html

it seems Russell hasn't given feedback yet. i am not sure Russell's
opinion about how to suspend/resume l2 for SoCs whose l2 cache will
lose in suspend cycle. in my opinion, a complete re-init is simplest.

For imx6q and omap who will not lose l2 in suspend cycle, Russell sent
a patchset about suspend and required l2 re-enabled before cpu_resume
by omap/imx6q platform-specific codes.

>
> ? ? ? ?Arnd

Thanks
barry
