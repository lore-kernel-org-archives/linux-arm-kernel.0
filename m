From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 14:57:54 +0000
Subject: [PATCH] ASoC: skip resume of soc-audio devices without codecs
In-Reply-To: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
References: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20111123145754.GF20272@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:37:00PM +0800, Eric Miao wrote:
> There are cases where there is no working codec on the soc-audio devices,
> and snd_soc_suspend() will skip such device when suspending. Yet its
> counterpart snd_soc_resume() does not check this, causing complaints
> about spinlock lockup:

Applied, thanks.  It'll be really nice when Grant's probe deferral stuff
comes in and we can stop having to do things like this...
