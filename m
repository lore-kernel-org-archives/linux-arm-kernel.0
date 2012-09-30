From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 30 Sep 2012 10:31:36 -0400
Subject: [kvmarm] [PATCH 10/15] KVM: ARM: World-switch implementation
In-Reply-To: <CAFEAcA_=Lk7yUep6h+S=p9URT4jNqq2wVBjN8cALPPGV=A5+1w@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153533.21241.82489.stgit@ubuntu>
 <20120925170031.GF28728@mudshark.cambridge.arm.com>
 <CAFEAcA-69tmRdZkZ9dsSk9ck-AC7tKmYvxyxGGVA6ocKDRB25A@mail.gmail.com>
 <2f4c4963f36aabf6e5f48ad42bf145f2@localhost>
 <CANM98q+gBZ-msYxp=aOhHLJboweuJ35CQQ602gcqE7-PjsYe-A@mail.gmail.com>
 <CAFEAcA_=Lk7yUep6h+S=p9URT4jNqq2wVBjN8cALPPGV=A5+1w@mail.gmail.com>
Message-ID: <CANM98qJRM=1JrpmderGf-4M=7YXm3cVCbraQCxFxq_HFGydbcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 5:48 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 September 2012 01:33, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
>> On Tue, Sep 25, 2012 at 1:42 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Well, we're still in HYP mode when performing the pop, so the VMID is
>>> pretty much irrelevant. Same for the initial push, actually. As long as
>>> we're sure VTTBR has been updated when we do the exception return, I think
>>> we're safe.
>>>
>> yeah we're safe, but I can't find anywhere that says the ISB is
>> implied from exception handling/hvc, even though I seem to recall
>> having read this, so I put this here not to worry other readers.
>
> "TLB maintenance operations and the memory order model" in section
> B3.10.1 of the ARM ARM says that exception entry forces completion of
> TLB maintenance ops. Section B5.6.3 ("Synchronization of changes to
> system control registers") says that taking an exception synchronizes
> context, so the VTTBR update is guaranteed to have happened.
>
thanks - I was counting on your help here :)

-Christoffer
