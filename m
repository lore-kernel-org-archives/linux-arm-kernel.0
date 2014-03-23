From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 22 Mar 2014 20:19:52 -0700
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <532D4505.1090603@redhat.com>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk>
 <531843EE.8040102@redhat.com> <53185FB9.1040308@redhat.com>
 <20140306120449.GA29916@mal.justgohome.co.uk>
 <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
 <20140322010206.GF25519@cbox> <532D4505.1090603@redhat.com>
Message-ID: <20140323031952.GB30885@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 09:08:37AM +0100, Paolo Bonzini wrote:
> Il 22/03/2014 03:29, Christoffer Dall ha scritto:
> >1. Simply mandate that VM implementations support persistent variables
> >   for their UEFI implementation - with whatever constraints that may
> >   put on higher level tools.
> >
> >2. Require that OSes shipped as part of compliant VM images make no
> >   assumption that changes to the UEFI environment will be stored.
> >
> >I feel that option number two will break in all sorts of cases, just
> >like Grant stated above, and it is fundamentally not practical; if a
> >distribution ships Linux with a UEFI stub that expects to be able to do
> >something, distributions must modify Linux to conform to this spec.  I
> >think imagining that this spec controls how UEFI support in Linux/Grub
> >is done in general would be overreaching.  Additionally, Michael brought
> >up the fact that it would be non-UEFI compliant.
> 
> OSes are already able to cope with loss of changes to UEFI
> environment are stored, because losing persistent variables is what
> happens if you copy an image to a new hard disk.
> 
> Asking implementations for support of persistent variables is a good
> idea; however, independent of what is in the spec, OSes should not
> expect that users will enable that support---most of them won't.
> 
OK, fair enough, mandating support for persistent variable storage may
be overreaching but at the same time I feel it is unlikely for this spec
to reach far enough that a generic UEFI Linux loader, for example,
actually follows it, and therefore explicitly mandating that guest OSes
must be completely portable in all that they do is a non-practical
constraint.  That was the request that kicked this discussion off, and
what I was trygint to address.

-Christoffer
