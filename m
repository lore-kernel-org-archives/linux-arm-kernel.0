From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 10 Jul 2018 17:25:27 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com>
 <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
Message-ID: <20180710152527.GA3616@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

On 07/04, Ravi Bangoria wrote:
>
> > Now I understand what did you mean by "for each consumer". So if we move this logic
> > into install/remove_breakpoint as I tried to suggest, we will also need another error
> > code for the case when verify_opcode() returns false.
>
> Ok so if we can use verify_opcode() inside install_breakpoint(), we can probably
> move implementation logic in install/remove_breakpoint(). Let me explore that more.

No, sorry for confusion, I meant another thing... But please forget. If we rely on
verify_opcode() I no longer think it would be more clean to move this logic into
install/remove_breakpoint.

However, I still think it would be better to avoid uprobe exporting and modifying
set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
I'll re-check...

Oleg.
