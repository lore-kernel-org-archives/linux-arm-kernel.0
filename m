From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 9 May 2010 10:26:26 -0700
Subject: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
In-Reply-To: <l2r1b68c6791005090306ld948bebfqa1e7d22321e302aa@mail.gmail.com>
References: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
	<20100507093256.GB19936@n2100.arm.linux.org.uk>
	<x2j63386a3d1005070443yfadbaf3ct8686a8f7aae6412f@mail.gmail.com>
	<j2r1b68c6791005070531u57b4b1basc56d45d0e06b1d04@mail.gmail.com>
	<k2k63386a3d1005070910kcdb516dcga60c24043b1b44de@mail.gmail.com>
	<m2u1b68c6791005071937s5b2bbb60p6de395a6c06a963e@mail.gmail.com>
	<w2re9c3a7c21005081524z2a52a078nad8d316553dfde80@mail.gmail.com>
	<l2j1b68c6791005082048j5deaf863g2887c968ff841f2f@mail.gmail.com>
	<h2ie9c3a7c21005090047lf1157930t9a625073c87e8cea@mail.gmail.com>
	<l2r1b68c6791005090306ld948bebfqa1e7d22321e302aa@mail.gmail.com>
Message-ID: <k2le9c3a7c21005091026y9140dd46i8020c49ebef7c06c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 9, 2010 at 3:06 AM, jassi brar <jassisinghbrar@gmail.com> wrote:
> This discussion is purely about what the current DMA API misses and what
> a generic DMA API should do. So, that the current DMA API fills up those
> gap, if possible. I would love to get started implementing the generic
> DMA API for reference but my priorities are decided by my employer.

Well, the only significant miss that has been identified so far is
dynamic channel allocation for the device-to-mem case.  Everything
else can be done with small tweaks to the existing interface.  But
some of this discussion reminds me of Section 2.4 of
Documentaion/SubmittingPatches:

4) Don't over-design.

Don't try to anticipate nebulous future cases which may or may not
be useful:  "Make it as simple as you can, and no simpler."

Let's just wait for the code before outlining what can and cannot be
done, especially given where we started [1].

--
Dan

[1]: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/linux/dmaengine.h;hb=v2.6.18#l160
