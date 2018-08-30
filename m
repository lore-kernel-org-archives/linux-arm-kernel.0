From: james.morse@arm.com (James Morse)
Date: Thu, 30 Aug 2018 17:34:30 +0100
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <20180830104307.GC20005@nazgul.tnic>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <20180830104307.GC20005@nazgul.tnic>
Message-ID: <150ad0e4-e84a-565b-95ac-e7135e98bdc0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 30/08/18 11:43, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 06:33:52PM +0000, Fan Wu wrote:
>> The current ghes_edac driver does not update per-dimm error
>> counters when reporting memory errors, because there is no
>> platform-independent way to find DIMMs based on the error
>> information provided by firmware. This patch offers a solution
>> for platforms whose firmwares provide valid module handles
>> (SMBIOS type 17) in error records. In this case ghes_edac will
>> use the module handles to locate DIMMs and thus makes per-dimm
>> error reporting possible.

> If we're going to do this, it needs to be tested on an x86 box which loads
> ghes_edac. Adding Toshi to Cc.

Good point, thanks.


> Otherwise it must remain ARM-specific.

Hmmm, that would be a shame.

This should only be a problem if HPE Servers set CPER_MEM_VALID_MODULE_HANDLE,
but don't actually provide module handles, or if firmware has a different idea
of what they are.

If firmware never sets CPER_MEM_VALID_MODULE_HANDLE, this patch shouldn't change
anything.

(Someone must have an x86 that sets CPER_MEM_VALID_MODULE_HANDLE, otherwise the
code wouldn't be there right?!)


Thanks,

James
