From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 Jul 2016 15:46:17 +0200
Subject: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
In-Reply-To: <20160702133243.GB20045@piout.net>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
 <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
 <20160702110227.GB4604@lukather>
 <9b02394e-b38b-c804-780b-e9707c292486@redhat.com>
 <20160702133243.GB20045@piout.net>
Message-ID: <20160702134617.GC4604@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 02, 2016 at 03:32:43PM +0200, Alexandre Belloni wrote:
> > > > I believe that the best way to deal with this is to add an
> > > > "allwinner,general-purpose-mode" flag to the existing binding
> > > > (as well as document general purpose mode in the existing
> > > > binding rather then in a new binding doc).
> > > > 
> > > > That seems to be the right thing to do purely looking at this
> > > > from a dt binding pov.
> > > 
> > > There's a way simpler solution: if there's no child nodes, it's meant
> > > to be used as an ADC, otherwise, as input.
> > > 
> > > The logic will have to be a bit more complex than that, since there's
> > > two channels, and you could only require one for the buttons, leaving
> > > the other one available as an ADC.
> > > 
> > > But that doesn't require any new property.
> > 
> > True, if there are no button nodes, then go general-purpose will
> > work too.
> 
> Well, I'd still argue that we need two different compatibles because
> encoding the usage of an IP in its compatible string is less than ideal.

That's true, but it's what we have.

So feel free to add a new compatible if you want, but we'll have to
support the old one anyway.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160702/a87c13a3/attachment.sig>
