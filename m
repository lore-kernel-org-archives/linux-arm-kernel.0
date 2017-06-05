From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 5 Jun 2017 10:23:21 +0200
Subject: [PATCH v2 03/25] KVM: arm64: Make kvm_condition_valid32()
 accessible from EL2
In-Reply-To: <394ef6fd-1123-0a1f-f462-ed5cb52e24da@arm.com>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
 <20170601102117.17750-4-marc.zyngier@arm.com>
 <20170604121129.GB9464@cbox>
 <394ef6fd-1123-0a1f-f462-ed5cb52e24da@arm.com>
Message-ID: <20170605082321.GA8984@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 09:13:53AM +0100, Marc Zyngier wrote:
> On 04/06/17 13:11, Christoffer Dall wrote:
> > On Thu, Jun 01, 2017 at 11:20:55AM +0100, Marc Zyngier wrote:
> >> As we're about to trap CP15 accesses and handle them at EL2, we
> >> need to evaluate whether or not the condition flags are valid,
> >> as an implementation is allowed to trap despite the condition
> >> not being met.
> >>
> >> Tagging the function as __hyp_text allows this.
> > 
> > is the cc_map also guaranteed to work (by simple reference) in EL2 then?
> 
> Yes. By virtue of being const, this ends up in the read-only part of the
> kernel, which we always map at EL2.
> 

And why don't we have to do any address-translation-to-hyp tricks on the
address?  Are we guaranteed that it's a relative address and everything
is relocated with the same offset, or how was that again?

Thanks,
-Christoffer
