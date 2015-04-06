From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Apr 2015 17:19:39 +0100
Subject: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
In-Reply-To: <551D8EB6.1050004@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
 <20150331064209.GD2869@sirena.org.uk>
 <551D8EB6.1050004@broadcom.com>
Message-ID: <20150406161939.GJ6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 11:47:18AM -0700, Lori Hikichi wrote:
> On 15-03-30 11:42 PM, Mark Brown wrote:

> >>+config SND_SOC_CYGNUS
> >>+	tristate "SoC platform audio for Broadcom Cygnus chips"
> >>+	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> >>+	default ARCH_BCM_CYGNUS

> Okay.

You don't need to reply to every single comment, the general assumption
will be that if there's no other followup all review comments will be
addressed.  It's better to just reply to things where there's something
more detailed to say, if you explicitly reply to everything then that
makes it easier for actual replies to be missed since there's a lot of
there's a lot of the mail that's just going to be skipped through.

> >>+static void ringbuf_inc(void __iomem *audio_io, bool is_playback,
> >>+			const struct ringbuf_regs *p_rbuf)

> >So it looks like we're getting an interrupt per period and we have to
> >manually advance to the next one?

> Yes.

OK, so that seems fragile - what happens if we're slightly late
processing an interrupt or miss one entirely?  Most hardware has some
way to read back the current position which tends to be more reliable,
is that not an option here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/f7e5d81d/attachment.sig>
