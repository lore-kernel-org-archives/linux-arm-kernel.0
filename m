From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 01:24:59 -0700
Subject: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
In-Reply-To: <87ppvlqhyy.fsf@lebrac.rtp-net.org>
References: <20130517191753.468.1734.stgit@localhost>
 <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
 <20130612163124.GD8164@atomide.com>
 <20130612171407.GM8164@atomide.com> <51B98F1E.1000006@ti.com>
 <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com> <87ppvlqhyy.fsf@lebrac.rtp-net.org>
Message-ID: <20130617082458.GH20992@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [130617 01:13]:
> 
> I hoped to have missed some mails and that people were testing pandabard
> support with full support but given what I see, the ethernet support is
> not there yet. This thread is about removing the non-DT boot. I see some
> contradiction here. Please, look again at what Thomas said in the IGEP thread:
> breaking existing support is bad and removing non-DT boot for panda with
> not-working ethernet would exactly to that.

Hmm yes I guess the panda needs the aux clock and there are various
patches posted for that for quite a while but have not gotten merged.

When I did my patches it seemed that Nishant's and my solution for
getting the auxclk via DT was acceptable. Then Mike started doing
all the clocks in DT and things changed.

Mike, got any solution for us for v3.11 for the DT defined auxclk?
 
> Yeah, I'm aware that some extra patches are being developped like the
> omap clocks one: https://patchwork.kernel.org/patch/2541331/ but they
> don't seem to be in -next. So, again, please, wait that all needed bits
> are merged mainline before killing non-DT support (or provide 'mixed'
> support like what is/was done on kirkwood)

The ethernet issue can be fixed with the legacy mode support in the
worst case, but probably just adding a clock alias for it does the
trick.

I'd rather not postpone making omap4 DT only because I think at this
point fixing the any DT related issues is way less work compared to
maintaining and testing both legacy boot and DT boot.

Regards,

Tony
