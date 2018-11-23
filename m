From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Nov 2018 00:03:01 +0800
Subject: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
In-Reply-To: <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
References: <20181122102325.29495-1-wens@csie.org>
 <2007258.VzpTJLJblp@anarsoul-thinkpad>
 <CAGb2v67J6ptnr_uPW0+H=WvCdAVzZ1Sw1wTUQrr6KrNsc_mXKQ@mail.gmail.com>
Message-ID: <CAGb2v66e7KmCLDgj8XFAbNhfg5txBnxE5svP30Zm0=p30mBF2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 12:37 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Nov 23, 2018 at 12:26 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Thursday, November 22, 2018 2:23:17 AM PST Chen-Yu Tsai wrote:
> > > Hi everyone,
> > >
> > > This is v9 of the A64 audio codec series, originally started by Vasily.
> > > These are the last changes to make the A64 audio codec work correctly,
> > > and be accurately represented in the device tree and in software.
> > >
> > > Notably, the new driver changes cover regulator supplies for the simple
> > > audio amplifier, which is used in the Pinebook for the internal
> > > speakers, and the audio codec's internal headphone amp. There's also an
> > > extra patch that enables SDM fractional clock support for the audio PLL
> > > on the A64, which gives us accurate audio playback.
> > >
> > > Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
> > > dt bindings & driver.
> > >
> > > Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
> > > bindings & driver.
> > >
> > > Patch 5 adds SDM fractional clock support for the audio PLL on the A64.
> > >
> > > Patch 6 ~ 8 add the device tree bits and enables audio on several
> > > boards.
> > >
> > > I have one extra patch for the Bananapi M64 that's not included here,
> > > as I'm waiting for an accessory to test the microphone bias. I'll send
> > > that one out once it's tested.
> > >
> > > As always, we'll take the clock and dts patches after Mark has merged
> > > the ASoC ones.
> > >
> > > And a big thanks to Vasily for having worked on this for so long.
> >
> > Thank you for picking it up!
> >
> > Just a minor note: hpvcc-supply should be a property of codec_analog in
> > sun50i-a64-pinebook.dts
>
> Thanks. I'll fix that up when applying.

Merged the remaining 4 patches with the misplaced regulator supply property
in the last patch fixed.

ChenYu

> > Otherwise looks fine, tested on Pinebook and Pine64-LTS.
> >
> > Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Great!
>
> ChenYu
