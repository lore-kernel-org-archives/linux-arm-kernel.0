From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 8 Sep 2017 14:11:40 +0100
Subject: [PATCH v2 19/28] arm64/sve: ptrace and ELF coredump support
In-Reply-To: <5FA513F682BE7F4EAAB8EE035D5B08E44109EBDF@G01JPEXMBKW02>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-20-git-send-email-Dave.Martin@arm.com>
 <5FA513F682BE7F4EAAB8EE035D5B08E44109DFE8@G01JPEXMBKW02>
 <20170906181634.GF6321@e103592.cambridge.arm.com>
 <5FA513F682BE7F4EAAB8EE035D5B08E44109EBDF@G01JPEXMBKW02>
Message-ID: <20170908131136.GG6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 05:11:45AM +0000, Okamoto, Takayuki wrote:
> Hi Dave,
> 
> Thank you for your reply.
> 
> > Your fix looks correct and seems to work.  For stylistic reasons, I may
> > write it like this instead, but the effect should be the same:
> > 
> > 	header->max_vl = sve_max_vl;
> > 	if (WARN_ON(!sve_vl_valid(sve_max_vl))
> > 		header->max_vl = header->vl;
> 
> It is better than my fix.
> Please, apply it at next version.

I've rebased to v4.13 and pushed a branch to track fixes against v2,
here:

 * http://linux-arm.org/git?p=linux-dm.git;a=shortlog;h=refs/heads/sve/v2%2Bfixes

 * git://linux-arm.org/linux-dm.git sve/v2+fixes

Cheers
---Dave
