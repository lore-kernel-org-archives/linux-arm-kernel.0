From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Tue, 30 Aug 2016 20:10:25 +0200
Subject: [linux-sunxi] [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
In-Reply-To: <CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow@mail.gmail.com>
References: <20160829180321.11695-1-dannym@scratchpost.org>
 <20160829180321.11695-3-dannym@scratchpost.org>
 <CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow@mail.gmail.com>
Message-ID: <20160830201025.506b30ae@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 30 Aug 2016 08:49:40 +0200
Code Kipper <codekipper@gmail.com> wrote:

> On 29 August 2016 at 20:03, Danny Milosavljevic <dannym@scratchpost.org> wrote:
> I think this should be delivered in a series of patches like what I've
> attempted to do here
> https://github.com/codekipper/linux-sunxi/commits/sunxi-wip?page=2

Feel free to do it. But I've gotten questions from users why they have to
apply my patch manually again and again, so let's get this done one way
or another.

> I haven't worked with my A20 for a while which is why I haven't
> delivered these changes, however summer is coming to an end and should
> be able to retest and deliver soon.

Good :)

Please check whether you use the same routes and registers in your
version - my patch has been in use by multiple people for months
so I'm quite positive that it works, whatever cosmetic issues there may be.

Especially pay attention to Line Playback Volume - it has two possible values.

0 means -1.5 dB and 1 means 0 dB. Many userspace tools seem to be confused
about it not being a boolean and alsa-lib also did stupid stuff with it
depending on the name. So make sure that it does work.

Also if someone tests my patch, please also test this.

(It has been notoriously difficult to reproduce this problem reliably
 in the past with different people's setups)

> I can see that there is a difference like you've mentioned between the
> A10 and A20 with the MIC pre-amps so approve of the use of a common
> array.

Yeah, it's necessary.

> Something also looks wrong with the whitespacing for sun4i_codec_codec.

Depends on your tab width - the committed version used Tab characters in
order to line up the equals signs. So it was really just luck how it looked.

That means that depending on the tab width it did either line up or not
(it didn't line up for me).

Now it's using spaces around the equal sign and so it shows up
the same for everyone - lined up. I fixed this because I touched the line
anyway.
