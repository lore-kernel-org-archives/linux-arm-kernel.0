From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 23 Nov 2011 23:19:14 +0800
Subject: [PATCH] ASoC: skip resume of soc-audio devices without codecs
In-Reply-To: <20111123145828.GG20272@opensource.wolfsonmicro.com>
References: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
 <20111123145828.GG20272@opensource.wolfsonmicro.com>
Message-ID: <CAMPhdO-f+tjbbyDuFDPUwERKpHfUuJJTha_pzc6BVBqy4LFrWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 23, 2011 at 10:37:00PM +0800, Eric Miao wrote:
>> There are cases where there is no working codec on the soc-audio devices,
>> and snd_soc_suspend() will skip such device when suspending. Yet its
>> counterpart snd_soc_resume() does not check this, causing complaints
>> about spinlock lockup:
>
> Oh, and I just noticed that you didn't CC either Liam or the ALSA list
> which you really should've done.

Noted.
