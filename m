From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 23:24:46 +0200
Subject: [PATCH v3 1/8] rsb: Add generic Reduced Serial Bus (RSB)
 controller binding documentation
In-Reply-To: <CAGb2v65jnU859gQG0orb9M9pR6nKcth9EPcgmmR5fckdHxngrQ@mail.gmail.com>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
 <1439958009-14056-2-git-send-email-wens@csie.org>
 <20150820150845.GB30520@lukather>
 <CAGb2v65jnU859gQG0orb9M9pR6nKcth9EPcgmmR5fckdHxngrQ@mail.gmail.com>
Message-ID: <20150820212446.GK30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:58:39PM +0800, Chen-Yu Tsai wrote:
> >> +Child nodes:
> >> +
> >> +An RSB controller node can contain zero or more child nodes representing
> >> +slave devices on the bus.  Child 'reg' properties are specified as a
> >> +runtime address, hardware address pair. The hardware address is hardwired
> >> +in the device, which can normally be found in the datasheet. The runtime
> >> +address is set by software. No 2 devices on the same bus shall have the
> >> +same runtime address.
> >> +
> >> +Valid runtime addresses - There are only 15 valid runtime addresses:
> >> +
> >> +    0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74, 0x8b,
> >> +    0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff
> >> +
> >> +It is highly recommended that one choose the same runtime addresses as
> >> +vendor BSPs use so that a) the addresses remain the same across different
> >> +software systems, and b) addresses of supported and listed slave devices
> >> +don't conflict with unsupported or not yet listed devices.
> >
> > I'd expect to have the hardware address first, but maybe it's just me
> > :)
> 
> I don't know. It's only used at init time.
> 
> And in my latest experience, once the runtime address is set by the
> bootloader, it can't be changed. My earlier experience was the opposite,
> though I haven't figured out why.

Note that I'm only talking about the order of runtime and hardware
addresses in the reg property, having both is fine.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/298034df/attachment.sig>
