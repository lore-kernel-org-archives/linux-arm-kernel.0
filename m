From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 12:16:07 +0100
Subject: [linux-sunxi] Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add
 AXP209 support to various boards
In-Reply-To: <534BB670.8030102@redhat.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140414095256.GA28585@lukather>
 <CAOQ7t2ZybF=dm-NBQ3niN7gb-Asgwz5CW-VSkOzWR6t2NCaA8w@mail.gmail.com>
 <534BB670.8030102@redhat.com>
Message-ID: <20140414111607.GL28800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 12:20:32PM +0200, Hans de Goede wrote:

Please fix your mailer to word wrap at less than 80 columns.

> As Mark has also mentioned we should probably pin the regulators to a
> certain voltage, except for those which we expect to be controlled by
> a driver, so basically all of them should be pinned to a certain
> voltage except for DCDC2 which gets used for the cpu voltage which we
> will want to scale as soon as we've a cpufreq driver.

If you don't know what to do with the regulators and don't have any
information on what's safe then you shouldn't be specifying a voltage at
all.

> While testing the latest revision of your code I also noticed that the
> kernel ends up disabling LDO3 and LDO4, which could be fine on some
> boards and a problem on other boards.

> I think we need to be careful here. For now it may be best to only add
> the DCDC2 regulator to the dts, as we know that dcdc2 is used for the
> cpu voltage everywhere, and we will actually want to control that
> later on.

You need to at least specify that regulators that need to be kept on are
always-on.

> For the others, for the boards where we've schematics (*) it would be
> good to add the other regulators with fixed voltages as specified in
> the schematics. For the rest it may be best to simply leave the
> regulators alone / at their default settings.

If everyone has been running the board at a voltage different to that in
the schematic then I'd not assume that everything has been validated at
the voltage in the schematic, if production firmware is available that's
going to be a more reliable guide than the schematic but it sounds like
all these boards have just been left to run at their default voltages.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/c1fb3028/attachment.sig>
