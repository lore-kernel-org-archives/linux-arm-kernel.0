From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 02 Mar 2017 22:18:30 +1100
Subject: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <87varsj6qc.fsf@concordia.ellerman.id.au>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <87varsj6qc.fsf@concordia.ellerman.id.au>
Message-ID: <8737ewexkp.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> David Daney <david.daney@cavium.com> writes:
>> Strict alignment became necessary with commit 3821fd35b58d
>> ("jump_label: Reduce the size of struct static_key"), currently in
>> linux-next, which uses the two least significant bits of pointers to
>> __jump_table elements.
>
> It would obviously be nice if this could go in before the commit that
> exposes the breakage, but I guess that's problematic because Steve
> doesn't want to rebase the tracing tree.
>
> Steve I think you've already sent your pull request for this cycle? So I
> guess if this can go in your first batch of fixes?

Ugh. Was looking at the wrong tree - Linus has already merged the commit
in question, so the above is all moot.

cheers
