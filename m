From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 09:46:14 -0700
Subject: [PATCH v5 02/14] ARM: add V7_NONLPAE && V7_LPAE sub config
In-Reply-To: <1399473888-12947-3-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140507164614.GA12692@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 10:44:36PM +0800, Haojian Zhuang wrote:
> Since CONFIG_ARM_LPAE could be set in ARM V7, add new two configurations
> CONFIG_ARCH_MULTI_V7_NONLPAE & CONFIG_ARCH_MULTI_V7_LPAE.
> 
> If we want to enable CONFIG_ARM_LPAE configuration, we should enable
> CONFIG_ARCH_MULTI_V7 & disable both CONFIG_ARCH_MULTI_V6 and
> CONFIG_ARCH_MULTI_V7_NONLPAE.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

I don't like this. Platforms should just depend on CONFIG_ARCH_MULTI_V7 &&
LPAE (or && !LPAE) instead.

Platforms that _can_ boot without LPAE should not require it, even if
they boot with less available memory.


-Olof
