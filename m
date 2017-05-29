From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 10:59:39 +0200
Subject: [linux-sunxi] [PATCH 1/2] ARM: sun8i: v3s: add device nodes for
 DE2 display pipeline
In-Reply-To: <1B75138F-B045-4E60-BE92-B9AA343CBB1D@aosc.io>
References: <20170524111724.28431-1-icenowy@aosc.io>
 <CAGb2v65bZ+VJYwcP24ipQ+4kuY28Babt-Cpm7uscjmWpcoeJ9g@mail.gmail.com>
 <5FF9B3F8-01F6-4B17-958C-9A4245199716@aosc.io>
 <CAGb2v66UG7nS=3zj=TWGY-BG62tsvSpxucKHT35g=4KGcS8kRA@mail.gmail.com>
 <1B75138F-B045-4E60-BE92-B9AA343CBB1D@aosc.io>
Message-ID: <20170529085939.zstja3pymq77ubjq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 10:28:24PM +0800, Icenowy Zheng wrote:
> >>>> +                       compatible = "allwinner,sun8i-v3s-de2-mixer";
> >>>> +                       reg = <0x01100000 0x100000>;
> >>>
> >>>The display engine also has an interrupt. Please list it
> >>
> >> It's a overall interrupt for DE2, not mixer interrupt.
> >>
> >> I will add it after we have proper interrupt chaining facility
> >> for DE2.
> >>
> >> It cannot fit here in mixer node.
> >
> > Could you elaborate? If it is just shared, then listing it several
> > times is OK. If the interrupt registers are not in this address
> > space, then
> 
> The interrupt dealing code is still not so clear, and totally not
> present in BSP DE2 code (the BSP just didn't use the interrupt).
> 
> We doesn't even know where the interrupt register is, and we cannot
> promise it's not broken (as their is even no application of it in BSP).

Whether it's broken or not is out of the question here. Adding it
later would either break the DT compatibility, or introduce a crippled
driver for users that do not have a recent enough DT. None of the two
are really acceptable.

Especially if your plan is to add support for these.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/9163d8e5/attachment.sig>
