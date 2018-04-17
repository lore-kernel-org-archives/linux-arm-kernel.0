From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 13:19:02 +0200
Subject: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
In-Reply-To: <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-9-mylene.josserand@bootlin.com>
 <20180417075233.f2z6wxcazwqheoib@flea>
 <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
Message-ID: <20180417111902.4u6d3mxehxjqibe4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 03:57:07PM +0800, Chen-Yu Tsai wrote:
> >> @@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
> >>                       break;
> >>       }
> >>
> >> +     is_sun8i = sunxi_mc_smp_data[i].is_sun8i;
> >> +
> >
> > Do we really need to cache it? Can't we just have a pointer to the SMP
> > data structure and use that instead?
> 
> I recommended that. We don't need any of the other fields in the SMP
> data structure once we're past the init phase. This saves a dereference
> or two.

Fair enough.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/8d70754c/attachment.sig>
