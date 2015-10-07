From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 10:28:03 +0100
Subject: [linux-sunxi] [PATCH v2 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <CAGRGNgWw=eMn-YcALzE57xmumiydgH39S52LtuJO-+eT9vXQLQ@mail.gmail.com>
References: <1444054990-15946-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444054990-15946-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGRGNgXyaenitKnZNj4vLsgEDKe0CtTk=KqPADSs9588k1t+GA@mail.gmail.com>
 <20151006161756.GT2696@lukather>
 <CAGRGNgWw=eMn-YcALzE57xmumiydgH39S52LtuJO-+eT9vXQLQ@mail.gmail.com>
Message-ID: <20151007092803.GB2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 09:24:07AM +1100, Julian Calaby wrote:
> >> > +       chosen {
> >> > +               stdout-path = "serial0:115200n8";
> >>
> >> Should the composite output be enabled here too?
> >
> > AFAIK, the stdout-path only supports a single output device, and I
> > don't think it really is an issue since framebuffer console will
> > attach to the framebuffer automatically.
> 
> I was referring to enabling it in chosen, not stdout-path, but I
> couldn't remember if uboot does that for us or not.

It's not really u-boot that does that. the framebuffer console stuff
will attach automatically to the first framebuffer that comes in and
log the kernel logs there, it's all in-kernel.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/897ff114/attachment.sig>
