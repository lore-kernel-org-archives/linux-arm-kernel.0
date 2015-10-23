From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 20:09:27 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <5628C8E2.6040703@gmail.com>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151022080508.GN10947@lukather> <20151022102959.09f0a1f4@OPI2>
 <20151022084735.GR10947@lukather> <20151022105745.2cc158a3@OPI2>
 <20151022091410.GW10947@lukather> <5628C8E2.6040703@gmail.com>
Message-ID: <20151023180927.GJ10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 01:30:42PM +0200, Jens Kuske wrote:
> On 22/10/15 11:14, Maxime Ripard wrote:
> > On Thu, Oct 22, 2015 at 10:57:45AM +0200, Jean-Francois Moine wrote:
> >> On Thu, 22 Oct 2015 10:47:35 +0200
> >> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >>
> >>> Not really. The uart0 reset is the bit 16, in the reset register 4.
> >>>
> >>> 4 * 32 + 16 = 44.
> >>>
> >>> Not 112, but still not 208 either.
> >>
> >> The registers are numbered 1..5, then
> >>
> >> (4 - 1) * 32 + 16 = 112
> > 
> > Not on my version, and even then, UARTs are on the last reset
> > register, which would still make 144.
> > 
> > Maxime
> > 
> 
> There are holes between reg2 and reg3 and reg4 for some reason, but even
> if we would correct that with some of_xlate() function they won't
> completely line up with the gates.

Indeed. Still, dealing with the holes and sticking to what the
datasheet says seems like the right solution.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/3952eb74/attachment.sig>
