From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 16:56:27 +0000
Subject: regulator: tps65023 : Adding support for DT
In-Reply-To: <CAL8zT=jo2AsK9p_r_C+od_QEovOQNmo7MnNu9JtUHoA=KtsxGw@mail.gmail.com>
References: <CAL8zT=jo2AsK9p_r_C+od_QEovOQNmo7MnNu9JtUHoA=KtsxGw@mail.gmail.com>
Message-ID: <20141215165627.GF11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 09:36:26AM +0100, Jean-Michel Hautbois wrote:

> I started to add support for DT in this regulator, but I can't get a
> booting kernel with it. I know it lacks regulator init in the parse_dt
> function, but I don't really know what is the best way to do it. I
> have used tps6507x as an example until know...

Well, the best thing to do would be to backport the changes to add
support for DT parsing in the core and use that.  See "regulator: of:
Provide simplified DT parsing method" and preceeding commits in
mainline.  Otherwise what you've got looks basically OK from a quick
scan through.

> I don't know for instance if a tps_board is needed (it would contain
> only a struct regulator_init_data * so probably not very useful) ?

Probably not, no.

> Below is my current status (I also have created a tps65023.dtsi in
> arch/arm/boot/dts which is only a copy of tps6507x.dtsi so didn't copy
> it here).

If you need to create a .dsti file for a regulator that's a warning sign
- it should be empty.  You'll want things in the particular board but
that ought to be board specific things rather than something that
applies to all boards using the regulator.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/2c4207b3/attachment-0001.sig>
