From: panand@redhat.com (Pratyush Anand)
Date: Mon, 14 Mar 2016 09:34:55 +0530
Subject: [PATCH v11 4/9] arm64: add conditional instruction simulation
 support
In-Reply-To: <20160313120903.54b0c8f2@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-5-git-send-email-dave.long@linaro.org>
 <20160313120903.54b0c8f2@arm.com>
Message-ID: <20160314040455.GB6584@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2016:12:09:03 PM, Marc Zyngier wrote:
> On Wed,  9 Mar 2016 00:32:18 -0500
> David Long <dave.long@linaro.org> wrote:
> 
> > +pstate_check_t * const opcode_condition_checks[16] = {
> > +	__check_eq, __check_ne, __check_cs, __check_cc,
> > +	__check_mi, __check_pl, __check_vs, __check_vc,
> > +	__check_hi, __check_ls, __check_ge, __check_lt,
> > +	__check_gt, __check_le, __check_al, __check_al
> 
> The very last entry seems wrong, or is at least the opposite of what
> the current code has. It should be something called __check_nv(), and
> always return false (condition code NEVER).

May be __check_nv() name is more appropriate as per definition, but shouldn't it
still return true, because TRM says:
"The condition code NV exists only to provide a valid disassembly of the 0b1111
encoding, otherwise its behavior is identical to AL"

~Pratyush
