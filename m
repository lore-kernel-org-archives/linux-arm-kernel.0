From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 14:58:28 +0000
Subject: [PATCH] ASoC: skip resume of soc-audio devices without codecs
In-Reply-To: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
References: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20111123145828.GG20272@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:37:00PM +0800, Eric Miao wrote:
> There are cases where there is no working codec on the soc-audio devices,
> and snd_soc_suspend() will skip such device when suspending. Yet its
> counterpart snd_soc_resume() does not check this, causing complaints
> about spinlock lockup:

Oh, and I just noticed that you didn't CC either Liam or the ALSA list
which you really should've done.
