From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Sep 2015 21:14:03 +0200
Subject: [PATCH] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
In-Reply-To: <1441208649-6192-1-git-send-email-jarkko.nikula@bitmer.com>
 (Jarkko Nikula's message of "Wed, 2 Sep 2015 18:44:09 +0300")
References: <1441208649-6192-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <87pp1yxais.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jarkko Nikula <jarkko.nikula@bitmer.com> writes:

> From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
> build error here because it removed the type LPSS_SSP and I didn't notice
> the type was used here too.
>
> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
> accidentally by copying all enum pxa_ssp_type types from
> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>
> Fix the build error by removing this incorrect binding.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reported-by: Axel Lin <axel.lin@ingics.com>
> Cc: stable at vger.kernel.org # 4.2
> ---
> Sorry if you got this twice today. I had email problems today and this patch
> didn't go through to at least some of recipients. Resending from other my
> another address.

I'll take it through pxa tree, and I'll add this :
Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")

Up to my understanding this is the tag stable tree will use to know which kernel
version this patch should be applied to.

Cheers.

--
Robert
