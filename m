From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 21:17:46 +0200
Subject: [PATCH] ARM: KVM: fix unbalanced
 =?UTF-8?Q?get=5Fcpu=28=29=20in=20acc?= =?UTF-8?Q?ess=5Fdcsw?=
In-Reply-To: <20130412181332.GB5075@mudshark.cambridge.arm.com>
References: <1365786828-548-1-git-send-email-marc.zyngier@arm.com>
 <20130412181332.GB5075@mudshark.cambridge.arm.com>
Message-ID: <4a199cdd4998480ed6ba3f1858698903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Apr 2013 19:13:32 +0100, Will Deacon <will.deacon@arm.com>
wrote:
> On Fri, Apr 12, 2013 at 06:13:48PM +0100, Marc Zyngier wrote:
>> In the very unlikely event where a guest would be foolish enough to
>> *read* from a write-only cache maintainance register, we end up
>> with preemption disabled, due to a misplaced get_cpu().
>> 
>> Just move the "is_write" test outside of the critical section.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I found it second time around!
> 
>   Reported-by: Will Deacon <will.deacon@arm.com>

Indeed you did! :-)

I'll add that to the commit, and on a couple of other as well...

        M.
-- 
Fast, cheap, reliable. Pick two.
