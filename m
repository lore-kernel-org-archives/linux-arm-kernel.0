From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Mar 2015 22:31:51 +0000
Subject: [PATCH 2/5] arm64: alternative: Allow immediate branch as
 alternative instruction
In-Reply-To: <20150326221955.4b8fe6f0@arm.com>
References: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
 <1426773576-14062-3-git-send-email-marc.zyngier@arm.com>
 <20150326220323.GA23836@arm.com> <20150326221955.4b8fe6f0@arm.com>
Message-ID: <20150326223150.GD23836@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 10:19:55PM +0000, Marc Zyngier wrote:
> On Thu, 26 Mar 2015 22:03:23 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Mar 19, 2015 at 01:59:33PM +0000, Marc Zyngier wrote:
> > > +		for (i = 0; i < alt->alt_len; i += sizeof(insn)) {
> > > +			insn = get_alt_insn(origptr + i, replptr + i);
> > > +			*(u32 *)(origptr + i) = insn;
> > 
> > My brain's not firing on all cylinders right now, but do you need a
> > cpu_to_le32 here?
> 
> I'm not 100% awake myself (probably some acute form of firmwaritis),
> but I suspect you're quite right (get_alt_insn calls aarch64_insn_read,
> which does a le32_to_cpu). Obviously, we need to revert the conversion
> when writing the instruction back.
> 
> Do you want a fixup on top of this, or would you prefer me to respin
> the series?

Please respin and add my acks.

Will
