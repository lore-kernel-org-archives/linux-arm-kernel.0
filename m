From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 01:19:37 +0100
Subject: [PATCH 1/3] ALSA: pxa: slightly refactor reset handling
In-Reply-To: <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
 <20131017233607.GW2443@sirena.org.uk>
 <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
Message-ID: <20131018001937.GF2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 03:53:31AM +0400, Dmitry Eremin-Solenikov wrote:

> Maybe it was some coincidence/whatever. Maybe it is some hardware issue
> of exact mask version. When I first started hacking around PXA, it was known
> that tosa sometimes does not reset the AC97 codec for the first time.
> However it looks like nobody bothered to debug that, because in most (~3/4)
> cases reset went through. Now some kernel changes made kernel hang
> looping in the interrupt, if the reset is not properly handled.

Ah, now you mention that extra detail I do recall Wolfson CODEC drivers
with suspicious extra resets - probably this issue was why.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/5d896361/attachment.sig>
