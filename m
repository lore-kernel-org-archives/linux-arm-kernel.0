From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 24 Nov 2011 13:56:56 +0800
Subject: [PATCH] ASoC: skip resume of soc-audio devices without codecs
In-Reply-To: <CAMPhdO-f+tjbbyDuFDPUwERKpHfUuJJTha_pzc6BVBqy4LFrWw@mail.gmail.com>
References: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
 <20111123145828.GG20272@opensource.wolfsonmicro.com>
 <CAMPhdO-f+tjbbyDuFDPUwERKpHfUuJJTha_pzc6BVBqy4LFrWw@mail.gmail.com>
Message-ID: <CAMPhdO8J=ZLxt7SMry-jgGUTu+KGQaGAVdKfgGkeqAD5_Y=ojQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 11:19 PM, Eric Miao <eric.miao@linaro.org> wrote:
> On Wed, Nov 23, 2011 at 10:58 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Nov 23, 2011 at 10:37:00PM +0800, Eric Miao wrote:
>>> There are cases where there is no working codec on the soc-audio devices,
>>> and snd_soc_suspend() will skip such device when suspending. Yet its
>>> counterpart snd_soc_resume() does not check this, causing complaints
>>> about spinlock lockup:
>>
>> Oh, and I just noticed that you didn't CC either Liam or the ALSA list
>> which you really should've done.
>
> Noted.
>

BTW - I think it's applicable to previous kernel as well, so Cc stable
might be a good idea.
