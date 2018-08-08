From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 8 Aug 2018 15:03:31 +0100
Subject: [RFC PATCH 09/16] KVM: arm64: Allow ID registers to by
 dynamically read-as-zero
In-Reply-To: <20180808091111.GL9097@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-10-git-send-email-Dave.Martin@arm.com>
 <20180806130324.GA5985@e113682-lin.lund.arm.com>
 <20180807110958.GC9097@e103592.cambridge.arm.com>
 <20180807193512.GH5985@e113682-lin.lund.arm.com>
 <20180808091111.GL9097@e103592.cambridge.arm.com>
Message-ID: <CAFEAcA_9JDzj3NSrJcR6fkVm=Cuy71B_te+PUDJgDvV1gkDLSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2018 at 10:11, Dave Martin <Dave.Martin@arm.com> wrote:
> At its heart, I'm trying to abstract out the special behaviour of
> all unallocated ID registers, so that we can decide at runtime which
> ones to hide fro the guest: within the ID register block, each
> unallocated register becomes RAZ, not UNDEFINED as would be the case
> for other system registers, so we need to capture both behaviours.

I think a better way to think of the ID register block is
that all the registers in it *are* allocated. It's just that
some of them are specified as RAZ/WI (because no bits in
them have been given meaning yet). Then you retain the
straightforward "unallocated == UNDEF". (In the Arm ARM
the gaps in the ID register block are documented as
"reserved, RAZ", not "unallocated".)

thanks
-- PMM
