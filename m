From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Oct 2014 15:25:46 +0200
Subject: [PATCH 3/3] ARM: sun7i: cubieboard2: Enable the AXP209
In-Reply-To: <CAGb2v65goZ6nf2Bk3m4oZWHv98+F=ZZSEcKx+9ni-JRgMCqokw@mail.gmail.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411243596-15117-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67j6bqY7tU6ky9r1nSx_2ZaqqvNX5CAuoPwfX_1McXS0g@mail.gmail.com>
 <20141006120717.GI4090@lukather>
 <CAGb2v65goZ6nf2Bk3m4oZWHv98+F=ZZSEcKx+9ni-JRgMCqokw@mail.gmail.com>
Message-ID: <20141006132546.GJ4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 08:16:47PM +0800, Chen-Yu Tsai wrote:
> BTW,
> 
> On Mon, Oct 6, 2014 at 8:07 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Oct 03, 2014 at 04:49:25PM +0800, Chen-Yu Tsai wrote:
> >> Hi,
> >>
> >> On Sun, Sep 21, 2014 at 4:06 AM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Add the AXP209 PMIC with the regulators in use on the cubie2.
> >> >
> >> > The RTC regulator can be disabled, but since the RTC driver doesn't grab the
> >> > regulator for now, the driver wouldn't work anymore.
> 
> This is wrong. The RTC regulator, i.e. LDO1, can not be disabled.
> From the datasheet: "LDO1?30mA?????", or "Always effective/enabled".
> And it is defined in the driver without enabling controls.

Yeah, I know, it was supposed to be fixed too.

I ended up dropping this patch, and will resubmit it.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/d27736fb/attachment.sig>
