From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 14 Apr 2015 12:27:03 +0200
Subject: [PATCH v2 09/10] KVM: arm64: trap nested debug register access
In-Reply-To: <877ftglaqu.fsf@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-10-git-send-email-alex.bennee@linaro.org>
 <20150410123830.GB3227@hawk.usersys.redhat.com>
 <877ftglaqu.fsf@linaro.org>
Message-ID: <20150414102703.GW6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 08:59:21AM +0100, Alex Benn?e wrote:

[...]

> >> +		/* MDSCR_EL1 */
> >> +		if (r->reg == MDSCR_EL1) {
> >> +			if (p->is_write)
> >> +				vcpu_debug_saved_reg(vcpu, mdscr_el1) =
> >> +					*vcpu_reg(vcpu, p->Rt);
> >> +			else
> >> +				*vcpu_reg(vcpu, p->Rt) =
> >> +					vcpu_debug_saved_reg(vcpu, mdscr_el1);
> >
> > With this lines wrapping, {}'s might be nice.
> 
> My natural inclination is to wrap in {}'s but I know the kernel is a fan
> of the single-statement if forms.
> 
It's accepted to use braces for multi-line single statements - and I
prefer it too :)

-Christoffer
