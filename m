From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Jun 2013 13:13:17 +0100
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <CAOesGMh50Dzr_jczHZC5_txfW=6a+7EgFKvgZgj9MhUcVUTJ1Q@mail.gmail.com>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 <87sj1qzaov.fsf@linaro.org> <5191AA89.6010901@linaro.org>
 <20130528231740.GA28879@quad.lixom.net>
 <51A57D39.8030506@linaro.org>
 <CAOesGMh50Dzr_jczHZC5_txfW=6a+7EgFKvgZgj9MhUcVUTJ1Q@mail.gmail.com>
Message-ID: <20130604121317.GB31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 10:31:41PM -0700, Olof Johansson wrote:
> On Tue, May 28, 2013 at 8:59 PM, Tushar Behera <tushar.behera@linaro.org> wrote:

> > e. usb: ehci-s5p: add the HSIC port initialization
> > f. ARM: dts: Add USB gpio entries for Arndale board

> > I am not sure whether such kind of board-specific patches (e, f) are
> > appreciated in the drivers. But that is all we need to get USB and
> > Ethernet to work on v3.10-rc3 kernel.

> I've come across a similar situation with wifi reset sequence on the
> chromebook. On the product kernel we added some code to the board file
> to deal with it, but if we keep doing that things will grow out of
> hand.

> I don't know if it'll be unpopular, but I think it's time to start a
> drivers/platform/arm for these kind of things, and have those drivers
> probe on the system compatible value, similar to how x86 does it (with
> DMI tables). At least that's my plan for approaching the wifi
> reset/power-on sequence on the Chromebook. I hope to have patches in
> not all that long...

This does seem to be a fairly general problem for embedded systems with
devices on enumerable buses - it's even worse for things like Slimbus
where the expectation is that many devices will spend almost all of
their time powered down.  We probably need to come up with
infrastructure to enable the drivers for the individual devices to
handle this, or at least roll out such infrastructure more widely, IIRC
there's some DT stuff for PCI.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/fcb3868d/attachment.sig>
