From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 15:28:22 +0800
Subject: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <20120309071347.GM2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <4F5910EE.8090408@freescale.com>
 <20120309011914.GF2499@S2101-09.ap.freescale.net>
 <4F5966DC.6090201@freescale.com>
 <20120309071347.GM2499@S2101-09.ap.freescale.net>
Message-ID: <CAAQ0ZWQHm+SZgDA6x93=Q9CxAqz6uVu1F2UPBc=zafrhT71D1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 March 2012 15:13, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Mar 09, 2012 at 02:11:41AM +0000, Tabi Timur-B04825 wrote:
>> Shawn Guo wrote:
>> > Are you testing the patch set on top of the SHA below, which I
>> > mentioned in the cover letter?
>> >
>> > ? ?3030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc)
>> >
>> > I see the similar problem on the following SHA with my testing on
>> > imx-sgtl5000.
>> >
>> > ? ?1a8feca (Merge branch 'for-3.4' into asoc-next)
>>
>> It appears the problem is with for-3.4 itself. ?I'm running git-bisect now
>> to narrow it down.
>>
> My bisect tells that the offending commit is:
>
> ?96acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex)
>
> But I do not understand why yet.

=============================================
[ INFO: possible recursive locking detected ]
3.3.0-rc4+ #159 Not tainted
---------------------------------------------
aplay/395 is trying to acquire lock:
 (&codec->mutex){+.+...}, at: [<802f7414>] soc_widget_update_bits_locked+0x88/0x
1a0

but task is already holding lock:
 (&codec->mutex){+.+...}, at: [<802f9df4>] snd_soc_dapm_stream_event+0x38/0xc0
