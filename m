From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Tue, 9 Jan 2018 13:55:39 +0100
Subject: [PATCH v3 07/13] arm64: Add skeleton to harden the branch
 predictor against aliasing attacks
In-Reply-To: <1515432758-26440-8-git-send-email-will.deacon@arm.com>
References: <1515432758-26440-1-git-send-email-will.deacon@arm.com>
 <1515432758-26440-8-git-send-email-will.deacon@arm.com>
Message-ID: <CAOFm3uGsF31SBNy7E6OnDY-cZcnERS=3W9Qgp08twiePp_0ixg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will,

On Mon, Jan 8, 2018 at 6:32 PM, Will Deacon <will.deacon@arm.com> wrote:
> Aliasing attacks against CPU branch predictors can allow an attacker to
> redirect speculative control flow on some CPUs and potentially divulge
> information from one context to another.
>
> This patch adds initial skeleton code behind a new Kconfig option to
> enable implementation-specific mitigations against these attacks for
> CPUs that are affected.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

<snip>


> --- /dev/null
> +++ b/arch/arm64/kernel/bpi.S
> @@ -0,0 +1,55 @@
> +/*
> + * Contains CPU specific branch predictor invalidation sequences
> + *
> + * Copyright (C) 2018 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Could you consider using the new SDPX tags [1] instead of this long legalese?
Thanks!

[1] https://lkml.org/lkml/2017/12/28/323
-- 
Cordially
Philippe Ombredanne
