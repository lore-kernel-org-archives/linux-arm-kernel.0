From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Dec 2010 13:39:02 +0900
Subject: [PATCH 00/17] Samsung: Enable Audio Devices
In-Reply-To: <AANLkTinQ9zVY+0SBhHFJMRD6TVjnThEAy1zMwT_eHj5-@mail.gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<019301cba0ae$24902050$6db060f0$%kim@samsung.com>
	<AANLkTinQ9zVY+0SBhHFJMRD6TVjnThEAy1zMwT_eHj5-@mail.gmail.com>
Message-ID: <01fc01cba192$2b282720$81787560$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> On Tue, Dec 21, 2010 at 10:26 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Jassi Brar wrote:
> >>
> >> From: Jassi Brar <jassi.brar@samsung.com>
> >>
> >> Hi,
> >>   Next come patches that lay ground to enable audio devices on
> >> various latest SMDKS like 6440, 6442, 6450, C110, V210, V310 and C210.
> >> Actual enabing of these devices will be done by patchset to be sent to
> >> ASoC tree.
> >>
> > Hi Jassi,
> >
> > To apply your patches happen following build error in my for-next.
> >
> > 'error: 'samsung_asoc_dma' undeclared here (not in a function)'
> >
> > How can prevent build error?
> 
> hmmm... your tree doesn't have the commit 'ARM: Samsung: Define common
> audio-dma
> device' that I submitted to Mark.

Ok :-)

Mark,

As a note, I did 'cherry-pick' following 2 commits in my tree for avoiding build error.
I couldn?t 'merge' into my tree because there is no suitable branch in your tree...

--

commit 83e37b8e400ca51cc97946815b3055daacd92fa8
Author: Jassi Brar <jassi.brar@samsung.com>
Date:   Mon Nov 22 15:35:53 2010 +0900

    ARM: Samsung: Define common audio-dma device

    The ASoC uses common DMA driver for Audio devices. So it makes
    sense to a common audio-dma device shared across all platforms.

    Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
    Acked-by: Kukjin Kim <kgene.kim@samsung.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

commit 58bb4072132c54d832082cc6eac396a6db009cbd
Author: Jassi Brar <jassi.brar@samsung.com>
Date:   Mon Nov 22 15:35:50 2010 +0900

    ASoC: Samsung: Rename DMA device

    Some Samsung SoCs have a PCM(DSP) controller. So the name
    s3c24xx-pcm-audio for DMA driver is not very appropraite.
    This patch moves :-
        s3c24xx-pcm-audio -> samsung-audio

    Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
    Acked-by: Kukjin Kim <kgene.kim@samsung.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--

If any problems, please let me know :-)

Thanks.
Merry Christmas ;-)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
