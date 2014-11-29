From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 29 Nov 2014 17:21:46 +0100
Subject: [PATCH 4/7] KVM: arm64: guest debug, add SW break point support
In-Reply-To: <20141126160720.GD3245@hawk.usersys.redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-5-git-send-email-alex.bennee@linaro.org>
 <20141126160720.GD3245@hawk.usersys.redhat.com>
Message-ID: <20141129162146.GG23653@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:07:20PM +0100, Andrew Jones wrote:
> On Tue, Nov 25, 2014 at 04:10:02PM +0000, Alex Benn?e wrote:
> > This adds support for SW breakpoints inserted by userspace.
> > 
> > First we need to trap all BKPT exceptions in the hypervisor (ELS). This
> > in controlled through the MDCR_EL2 register. I've added a new field to
> > the vcpu structure to hold this value. There should be scope to
> > rationlise this with the VCPU_DEBUG_FLAGS/KVM_ARM64_DEBUG_DIRTY_SHIFT
> > manipulation in later patches.
> 
> I think we should start using the new mdcr_el2 field everywhere we plan
> to within the same series that it is introduced. Otherwise it's hard
> to tell if we need an mdcr_el2 field, or if a more generic field would
> suffice. We can always translate bits of a more generic field to
> mdcr_el2 bits when necessary, but not the reverse.
> 
Agreed, this is getting messy already with this patch.

-Christoffer
