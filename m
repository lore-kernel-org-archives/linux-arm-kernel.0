From: james.morse@arm.com (James Morse)
Date: Wed, 20 Apr 2016 17:56:58 +0100
Subject: [PATCH v7 12/16] arm64: Add new asm macro copy_page
In-Reply-To: <20160420163814.GF11377@e104818-lin.cambridge.arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-13-git-send-email-james.morse@arm.com>
 <20160420163814.GF11377@e104818-lin.cambridge.arm.com>
Message-ID: <5717B4DA.1090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/16 17:38, Catalin Marinas wrote:
> On Fri, Apr 01, 2016 at 05:53:36PM +0100, James Morse wrote:
>> From: Geoff Levand <geoff@infradead.org>
>>
>> Kexec and hibernate need to copy pages of memory, but may not have all
>> of the kernel mapped, and are unable to call copy_page().
>>
>> Add a simplistic copy_page() macro, that can be inlined in these
>> situations. lib/copy_page.S provides a bigger better version, but
>> uses more registers.
>>
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>> [Changed asm label to 9998, added commit message]
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Good enough for the brief usage:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

> Would there be another user of this macro in the future (kexec)?

Yes, this is one of the patches common to the two. Adding this macro was some
review feedback from kexec v12 [0].


Thanks,
James

[0] http://lists.infradead.org/pipermail/kexec/2015-December/014959.html
