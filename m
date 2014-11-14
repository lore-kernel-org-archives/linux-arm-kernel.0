From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 14 Nov 2014 22:57:50 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <54665E02.8050108@gmail.com>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd> <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
 <54665E02.8050108@gmail.com>
Message-ID: <20141114215749.GA19023@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 14, 2014 at 09:54:42PM +0200, Ivaylo Dimitrov wrote:
> On 14.11.2014 19:20, Sebastian Reichel wrote:
> >The patch looks ok. It does not cleanup the cmt-speech driver for
> >mainline usage, but it should work. Before adding this driver to the
> >mainline kernel there should be open source userspace support anyway.
> 
> I am aware of that(patch not ready), it's one of the reasons this
> patch still sits on gitorious IMO.
> 
> libcmtspeechdata was opened by Nokia long ago, so I don't understand what
> userspace support (for inclusion of the driver in the mainline kernel that
> is) is needed. see https://gitorious.org/meego-cellular/libcmtspeechdata/source/7f8f3ce357513e4849e1bf6d657980a514529c1a:

ah cool. I assumed, that userland stuff is mostly closed.

> REed pulseaudio modules that use cmtspeech will be ready sooner than later
> (I believe in 2-3 monts from now), see on gitorious how fast we progressed
> with -record and -music modules. Sure, -voice module is way more
> complicated, but lots of it is already opensourced, we just need to figure
> out a couple of DSP algorithms(drc, agc, aec, etc) related to call quality.
> But I don't think the driver should wait for those modules to be REed, they
> can be used as is even now, in their closed form for testing.

https://gitorious.org/pulseaudio-modules-nemo/jusas-tanuk2-mer-packaging/source/6ed34611b49c99b007f614d9dff4d58369876345:
https://github.com/nemomobile/pulseaudio-module-cmtspeech-n9xx/commits/master

It seems there is already cmtspeech code for pulseaudio?

> Unfortunately all my spare time is dedicated to that PA stuff, so
> I simply can't cleanup cmtspeech driver and send a patch for
> upstreaming. (Pavel, what about you?)

If somebody gets audio working with your driver and documents the
steps needed in userland I will take care of upstreaming the driver.

> >Btw. I am aware that this would break existing pulse audio stuff,
> >but wouldn't it make sense to export a V4L2 device instead of the
> >custom /dev/cmt_speech ABI?
> 
> Not to say that I agree with Pali's reply that working userspace should not
> be broken just for the sake of it.

Actually the mainline kernel never implemented that interface, so
there is no regression/break and I don't think introducing userspace
ABI's should be done carelessly - especially when there is also a
standardized interface.

> Nokia PA guys did a great job integrating lots of things related to audio
> and honestly, I don't see a reason why should we reinvent the wheel. There
> is lot more behind the scenes than simple PCM streaming (like audio policies
> and routing, sideband audio, speakers protection, etc) and reiplementing all
> this using different API wouldn't worth it IMO.

What has speaker protection to do with the modem interface?
Shouldn't this be two different PA modules?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/0ecb4cb2/attachment.sig>
