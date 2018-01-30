From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 30 Jan 2018 11:10:46 +0100
Subject: [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180130100023.GB18104@amd>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch> <20180130100023.GB18104@amd>
Message-ID: <20180130101046.GA16474@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 11:00:23AM +0100, Pavel Machek wrote:
> On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
> > On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijevi? wrote:
> > > Hi,
> > > 
> 
> > > > Well, notice I'm converting existing driver to device tree. And that
> > > > one already has GPIO dependency. It is possible that more work needs
> > > > to be done there, but that should not be a reason to delay this. Feel
> > > > free to help.
> > 
> > Adding DT properties that need to be maintained for compatibility reasons
> > is a bad idea and very good reason to delay merging unfinished stuff.
> > And meanwhile it turned out it is not power-gpio :)
> 
> I believe reset-gpios and power-gpios are commonly used like
> this... and that's what the old code does.

Why do you care about old code when introducing new DT property?
Either it is reset, then lets call it reset-gpios or it is power supply
and then voltage regulator should be used (VAUX4.OUT is such a regulator
although it is unclear to me how it is controlled (*)).

> You are not helping.

The only way I can help here is to resend your patch with "reset-gpios"
used, which I'm pretty sure you can handle yourself.

(*) Remark "DAC33 enabled (for example, plug in a headset to the 3.5mm
AV connector and start music playback from the device)" in schematics
suggests it is controlled somehow.
