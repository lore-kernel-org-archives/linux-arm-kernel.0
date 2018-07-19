From: james.morse@arm.com (James Morse)
Date: Thu, 19 Jul 2018 15:46:32 +0100
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
In-Reply-To: <20180719140102.GB25185@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
Message-ID: <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 19/07/18 15:01, Borislav Petkov wrote:
> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>> Enable per-layer error reporting for ARM systems so that the error
>> counters are incremented per-DIMM.
>>
>> On ARM systems that use firmware first error handling it is understood

understood by whom? Is this written down somewhere, or is it the convention. (in
which case, lets get it written down somewhere)


>> that card=channel and module=DIMM on that channel. Populate that
I'm guessing this is the mapping between CPER records and the DMItable data.


>> information and enable per layer error reporting for ARM systems so that
>> the EDAC error counters are incremented based on DIMM number as per the
>> SMBIOS table rather than just incrementing the noinfo counters on the
>> memory controller.

Does this work on x86, and its just the dmi/cper fields have a subtle difference?


> I guess.
> 
> James?

I don't know anything about this stuff. Looks like the SMBIOS specification is
my new bedtime reading.



Thanks,

James
