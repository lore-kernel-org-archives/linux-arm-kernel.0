From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 10:36:01 +0100
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
 <20150525173244.GE21577@sirena.org.uk>
 <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
Message-ID: <20150526093601.GH21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 08:17:23AM +0200, Tomeu Vizoso wrote:
> On 25 May 2015 at 19:32, Mark Brown <broonie@kernel.org> wrote:

> > The obvious questions here based on the name are why we're doing
> > something specific to platform devices and why this isn't something
> > we're abstracting in the driver core (or at least generic firmware code)
> > - we're going to have the same thing with ACPI.

> I don't know how useful this is going to be in systems with ACPI. My
> experience is limited to 32bit ARM, where the kernel has to manage
> every regulator, clock, gpio, etc so the dependency tree is so big. Is
> deferred probing a problem with ACPI as well?

Yes, x86 based embedded systems use ACPI (and we really ought to be
trying to help systems using board files too for that matter).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/3241d923/attachment.sig>
