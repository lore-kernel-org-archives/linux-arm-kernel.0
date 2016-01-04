From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 04 Jan 2016 11:21:46 -0800
Subject: [PATCH 6/6] arm64: switch to relative exception tables
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F39FA127B@ORSMSX114.amr.corp.intel.com>
References: <1451837157-447-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451837157-447-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160104144643.GE1616@arm.com> <568AB65A.8030901@zytor.com>
 <3908561D78D1C84285E8C5FCA982C28F39FA127B@ORSMSX114.amr.corp.intel.com>
Message-ID: <568AC64A.4090601@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2016 10:20 AM, Luck, Tony wrote:
>> May I humbly ask why the [Finnish] you don't use the equivalent of the
>> x86 _ASM_EXTABLE() macro?  In fact, why don't we make that one generic, too?
> 
> I'm messing with that right now (with help from Andy Lutomirski and Boris) to
> add different classes of exception table (so I can tag some instructions as being
> suitable for fixup from the machine check handler).  So it might not be generic
> for much longer.
> 
> http://marc.info/?l=linux-kernel&m=145187079504846&w=2
> 

I suspect that means we will also need to go back to arch-specific
sorting for x86.

	-hpa
