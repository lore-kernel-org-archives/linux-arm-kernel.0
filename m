From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 May 2016 20:17:28 +0100
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <87pot0pbnf.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
 <20160504090702.GV6292@sirena.org.uk>
 <87pot0pbnf.fsf@belgarion.home>
Message-ID: <20160505191728.GK6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 09:06:44PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I see that, I just don't know why that helps.

> Ok, so let me explain.

> As you already understood, AC97_VENDOR* is needed in bus.c for the
> autoscanning. The remaining is the reason why I don't want to include
> ac97_codec.h in bus.c, which follows.

> In order to have a clean split between former ac97 bus implementation and this
> new one, I didn't want to include any former ac97 includes, excepting in
> sound/ac97/compat.c.

It's probably a good idea to articulate some of this in the commit log
then!

> This transition will be easier if the new ac97 code is isolated as much as
> possible from the former code while providing backward compatibility ... hence
> this patch.

It'd probably have been clearer to me if it were splitting out all the
register definitions rather than just some of them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160505/2dd6048c/attachment.sig>
