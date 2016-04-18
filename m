From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 18 Apr 2016 14:41:21 +0100
Subject: [PATCH 4/5] arm64: Verify CPU errata work arounds on hotplugged
 CPU
In-Reply-To: <20160415141242.GM22906@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-5-git-send-email-suzuki.poulose@arm.com>
 <20160414173948.GO4584@arm.com> <570FD817.5050704@arm.com>
 <5710F653.5070301@arm.com> <20160415141242.GM22906@arm.com>
Message-ID: <5714E401.1090000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 15:12, Will Deacon wrote:
> On Fri, Apr 15, 2016 at 03:10:27PM +0100, Suzuki K Poulose wrote:
>> On 14/04/16 18:49, Suzuki K Poulose wrote:
>>> On 14/04/16 18:39, Will Deacon wrote:
>>>> On Wed, Apr 06, 2016 at 12:24:13PM +0100, Suzuki K Poulose wrote:
>>>>> CPU Errata work arounds are detected and applied to the
>>>>> kernel code at boot time and the data is then freed up.
>>>>> If a new hotplugged CPU requires a work around which
>>>>> was not applied at boot time, there is nothing we can
>>>>> do but simply fail the booting.
>>>>
>>>> Hmm, wouldn't it be better not to free the alternative text for errata
>>>> workarounds instead?
>>>
>>> We could. I don't have a strong opinion. If there are no objections, I could
>>> adopt it.
>>
>> The alternatives have been merged to .init by :
>>
>> commit 9aa4ec1571da6236 ("arm64: mm: fold alternatives into .init")
>>
>> Mark,
>>
>> Do you have any concerns on applying alternatives for CPUs turned online later ?
>> We have to revert the patch above to get going
>
> Well, note that I'm only suggesting that we keep the alternatives for
> CPU errata workarounds.

So to confirmt, do you mean for now we could do :

  - Not release the alternatives for errata work arounds.
  - And retain the check for new erratas, failing the CPUs.

And in a follow up series,

  - Add support for applying errata work arounds later, as we find
    a new CPU which requires it
  - and remove the constraint above ?


Suzuki
