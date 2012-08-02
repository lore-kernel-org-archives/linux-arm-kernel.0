From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Aug 2012 22:43:39 -0300
Subject: [PATCH] ARM: imx6q-sabrelite: Setup CLKO IOMUX
In-Reply-To: <20120802013958.GB2253@S2101-09.ap.freescale.net>
References: <1343869868-29490-1-git-send-email-festevam@gmail.com>
 <20120802013958.GB2253@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5BS-exRtxH8gkVtAki1AnY007uPB3oKcz56mnoaJ+EZGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 10:40 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 01, 2012 at 10:11:08PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> In order to have audio functional on mx6qsabrelite, it is necessary to setup
>> the IOMUX for MX6Q_PAD_GPIO_0__CCM_CLKO pins as it provides the audio clock.
>>
> The commit messages should generally be wrapped at column 72.  I fixed
> it up and queued the patch for 3.6-rc.  Thanks.

Ok, thanks.

With this patch applied audio is probed correctly now:

sgtl5000 0-000a: Using internal LDO instead of VDDD
sgtl5000 0-000a: sgtl5000 revision 0x11
imx-sgtl5000 sound.11:  sgtl5000 <-> 2028000.ssi mapping ok

,but I get error during aplay:

root at freescale /home$ aplay audio48k16S.wav
Playing WAVE 'audio48k16S.wav' : Signed 16 bit Little Endian,
Raimx-pcm-audio imx-pcm-audio: imx-pcm-audio hw params failed: -22
te 48000 Hz, Stereo
aplay: set_params:959: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (85333 85334)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: 4
BUFFER_TIME: (341333 341334)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0
root at freescale /home$

,and I guess this happens because of the missing mx6 sdma firmware.

Where can I get the mx6 sdma firmware binary from?

Thanks,

Fabio Estevam
