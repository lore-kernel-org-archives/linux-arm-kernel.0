From: lersek@redhat.com (Laszlo Ersek)
Date: Sat, 10 Jan 2015 21:08:11 +0100
Subject: Linux 3.19-rc3
In-Reply-To: <CA+55aFzXYhyBW_pF___69o98uq7nnH60wvnTr37RYmrjQgsdQA@mail.gmail.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>	<54AE7D53.2020305@redhat.com>	<20150109121348.GD12942@leverpostej>	<CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>	<54AFE53A.4020004@redhat.com>	<20150109175702.GA27787@leverpostej>	<54B01FF0.3020900@arm.com>	<20150109194333.GA23028@arm.com>	<54B09CA3.1060501@redhat.com>	<CA+55aFw3aGeiWOiKxQaC23VVX_Q9B0cDeZc37vVfK+SJVjGwFw@mail.gmail.com>	<20150110133742.GA6999@arm.com>	<54B181B7.5080503@redhat.com>
 <CA+55aFzXYhyBW_pF___69o98uq7nnH60wvnTr37RYmrjQgsdQA@mail.gmail.com>
Message-ID: <54B186AB.70806@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/15 20:56, Linus Torvalds wrote:
> On Sat, Jan 10, 2015 at 11:47 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> I grepped the tree for "fullmm", and only tlb_gather_mmu() seems to set
>> it. There are several instances of that function, but each sets fullmm to:
>>
>>         /* Is it from 0 to ~0? */
>>         tlb->fullmm     = !(start | (end+1));
>>
>> So, a nonzero fullmm seems to imply (end == ~0UL).
> 
> Yes. But note how it imples "end == ~0ul", but it does *not* imply
> "tlb->end" having that value.

Ooops! :)

> tlb->end is initialized to zero (not obvious, but it's what the call
> to __tlb_reset_range() does). It's then updated by
> __tlb_adjust_range() as we actually flush individual pages.

Thanks.
Laszlo
