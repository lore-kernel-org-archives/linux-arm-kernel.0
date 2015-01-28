From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 23:02:53 +0100
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <54C63F1C.6010703@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com>
Message-ID: <20150128220253.GB28275@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-01-26 15:20:28, Peter Ujfalusi wrote:
> On 01/18/2015 02:01 PM, Pavel Machek wrote:
> > Hi!
> > 
> > If you have any idea about playback problems, help would be still
> > welcome. I'll have to do bisect, otherwise, and it will not be easy.
> > 
> >> In 3.18, sound is nice and clear.
> >>
> >> In 3.19, sound is unusable. It produces nasty tone when it should be
> >> quiet, and there's at least as much noise as is sound.
> >>
> >> Unfortunately, list of mixers also changed (and there's cca 120
> >> settings), but a) it does not work with the old list and b) nothing I
> >> could figure out did make the sound usable. Some setting resulted in
> >> even more noise.
> >>
> >> Any idea what could have caused it?
> > 
> > I tried audio recording this time.
> > 
> > In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
> > mic", then it works. Input select being in "playback" option makes it
> > easy to miss.
> > 
> > In 3.18 and 3.19-rc3, all I can record are zeros.
> > 
> > Does playback/recording work for you on OMAP 3430-based machines?
> 
> Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards.
> BeagleBoard-xM also fine with twl4030 codec.
> 
> I don't have my n900 in hacking mode (it is still in use
> time-to-time) but

Actually, with nfsroot / loading kernel using NOLO, it is not
neccessary to break your n900. It is possible to boot complete
userspace without changing single bit of flash.

> looking at the dts file: you might want to add ai3x-micbias-vg property to the
> aic3x nodes to select the correct mic bias voltage. I can't recall what is
> appropriate for n900, but 2.6.28-nokia sources might give you the answer.

Ok, thanks, let me try...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
