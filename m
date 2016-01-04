From: tony.luck@intel.com (Luck, Tony)
Date: Mon, 4 Jan 2016 11:49:26 -0800
Subject: [PATCH 6/6] arm64: switch to relative exception tables
In-Reply-To: <CAKv+Gu-n70=Kdf2NtygzYxEURO+Dnk1cmMX6D3gmXQ1E5-PHUA@mail.gmail.com>
References: <1451837157-447-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451837157-447-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160104144643.GE1616@arm.com> <568AB65A.8030901@zytor.com>
 <3908561D78D1C84285E8C5FCA982C28F39FA127B@ORSMSX114.amr.corp.intel.com>
 <568AC64A.4090601@zytor.com>
 <CAKv+Gu-n70=Kdf2NtygzYxEURO+Dnk1cmMX6D3gmXQ1E5-PHUA@mail.gmail.com>
Message-ID: <20160104194925.GA19213@agluck-desk.sc.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 08:28:52PM +0100, Ard Biesheuvel wrote:
> On 4 January 2016 at 20:21, H. Peter Anvin <hpa@zytor.com> wrote:
> > I suspect that means we will also need to go back to arch-specific
> > sorting for x86.
> >
> 
> AFAICT, Tony's patches are not incompatible with mine. The fixup
> address is offset with a large constant, but this does not affect the
> sort order (since that is based on the other member), and the swap
> operation that adds/subtracts the delta should not care about the
> class bits. (I don't see any changes to sort_extable() in Tony's
> patch)

Correct. Sorting is by the "insn" field (which I did not change).
The "fixup" field is just modified by an offset value, so survives
the math when moved to a new slot by the sort.

> @Tony: any comments? And do you have any objections to the ia64 patch
> in this series?
The ia64 bits look OK. I haven't tested, but add my Acked-by: anyway.

-Tony
