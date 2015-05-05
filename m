From: robherring2@gmail.com (Rob Herring)
Date: Tue, 5 May 2015 11:41:15 -0500
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <1430820315.19516.26.camel@opteya.com>
References: <1430820315.19516.26.camel@opteya.com>
Message-ID: <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 5:05 AM, Yann Droneaud <ydroneaud@opteya.com> wrote:
> Hi,
>
> I believe Device Tree Blob (.dtb file) built from kernel's Device Tree
> Sources (.dts, which #include .dtsi, which #include .h) using Device
> Tree Compiler (dtc) are covered by GNU General Public Licence v2
> (GPLv2), but cannot find any reference.

By default yes, but we've been steering people to dual license them GPL/BSD.

> As most .dtsi in arch/arm/boot/dts/ are covered by GPLv2, and,
> as most .h in include/dt-bindings/ are also covered by GPLv2,
> the source code is likely covered by GPLv2.
>
> Then this source code is translated in a different language (flattened
> device tree), so the resulting translation is also likely covered by
> GPLv2.
>
> So, when I'm proposed to download a .dtb file from a random vendor,
> can I require to get the associated source code ?

I believe so yes. However, you already have the "source" for the most
part. Just run "dtc -I dtb -O dts <dtb file>". You loose the
preprocessing and include structure though (not necessarily a bad
thing IMO).

Then the question is what is the license on that generated dts!

> Anyway, for a .dtb file generated from kernel sources, it's rather
> painful to look after all .dts, .dtsi, .h, to find what kind of
> licences are applicables, as some are covered by BSD, dual licensed
> (any combination of X11, MIT, BSD, GPLv2).

I imagine the includes cause some licensing discrepancies if you dug into it.

Rob
