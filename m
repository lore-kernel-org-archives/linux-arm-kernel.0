From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Feb 2018 18:50:16 +0100
Subject: [PATCH v4 35/40] KVM: arm/arm64: Get rid of vgic_elrsr
In-Reply-To: <b15dda97-a860-0ed5-79d0-4c011f7e3b84@arm.com>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-36-christoffer.dall@linaro.org>
 <b15dda97-a860-0ed5-79d0-4c011f7e3b84@arm.com>
Message-ID: <20180223175016.GD7396@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 02:44:30PM +0000, Julien Grall wrote:
> Hi Christoffer,
> 
> On 15/02/18 21:03, Christoffer Dall wrote:
> >There is really no need to store the vgic_elrsr on the VGIC data
> >structures as the only need we have for the elrsr is to figure out if an
> >LR is inactive when we save the VGIC state upon returning from the
> >guest.  We can might as well store this in a temporary local variable.
> >
> >This also gets rid of the endianness conversion in the VGIC save
> >function, which is completely unnecessary and would actually result in
> >incorrect functionality on big-endian systems, because we are only using
> >typed values here and not converting pointers and reading different
> >types here.
> 
> I can't find any endianness code removed in this code. What did I miss?
> 

Ah, good find, we ended up fixing this in a separate commit:

fc396e066318, "KVM: arm/arm64: Fix broken GICH_ELRSR big endian conversion", 2017-12-03

I'll adjust the commit message.

Thanks,
-Christoffer
