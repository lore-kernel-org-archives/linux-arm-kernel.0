From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 11 Oct 2018 18:40:53 +0200
Subject: [PATCH v3] arm64: new board - Emlid Neutis N5
In-Reply-To: <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
Message-ID: <20181011164053.zxoucudslmz3w2yn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 03:20:11PM +0200, Andreas F?rber wrote:
> >> Also, I have a general comments, and it really depends on what your
> >> intention about the board ecosystem is. Do you expect the SOM to be
> >> swappable in multiple boards, or do you expect to send it as something
> >> that is just fixed into a daughter board?
> >>
> >> In the former case, you probably want to use overlays instead. In the
> >> latter, you're fine.
> >>
> > Right, we expect the SoM to be swappable. I agree, to use overlays is
> > more convenient, but
> > the devboard DT file will be a reference for the overlays and the future
> > boards based on Neutis.
> 
> What about just keeping the common nodes enabled in a SoM .dts, so that
> the average board doesn't need an Overlay for booting?

I guess the fundamental difference would be if the SoM can be run
free-standing or not. If it is, then overlays would be best. If not,
then I'm fine with using the include like Aleksandr has used.

> @Maxime/Rob, is it possible to merge .dtso files these days? If not,
> could that be considered in the big dts Makefile refactoring? :)

I don't really know what is that big dts Makefile refactoring you're
mentionning, but I don't think we can merge dtso before having the DT
connectors in place.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
