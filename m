From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2017 13:55:41 +0000
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
References: <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
Message-ID: <20170221135541.GV21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 01:02:21PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 21, 2017 at 12:26 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Tue, 21 Feb 2017 12:03:45 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> >> 1. For example,
> >>
> >> #define ATMEL_NFC_CMD(pos, cmd)                        ((cmd) <<
> >> (((pos) * 8) + 2))
> >
> > Well, I like to explicitly put parenthesis even when operator
> > precedence guarantees the order of the calculation ('*' is preceding
> > '+').
> 
> That's my point. I'm not a LISP programmer.
> Personally I think it makes readability worse.

+1.  I find unnecessary parenthesis is an effective obfuscation technique.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
