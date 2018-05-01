From: labbott@redhat.com (Laura Abbott)
Date: Tue, 1 May 2018 15:26:00 -0700
Subject: [PATCH] proc/kcore: Don't bounds check against address 0
In-Reply-To: <20180501144604.1cf872e7938bffc01a26349f@linux-foundation.org>
References: <1039518799.26129578.1525185916272.JavaMail.zimbra@redhat.com>
 <20180501201143.15121-1-labbott@redhat.com>
 <20180501144604.1cf872e7938bffc01a26349f@linux-foundation.org>
Message-ID: <4db64722-47b5-767c-4090-bdd9c1522e96@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2018 02:46 PM, Andrew Morton wrote:
> On Tue,  1 May 2018 13:11:43 -0700 Laura Abbott <labbott@redhat.com> wrote:
> 
>> The existing kcore code checks for bad addresses against
>> __va(0) with the assumption that this is the lowest address
>> on the system. This may not hold true on some systems (e.g.
>> arm64) and produce overflows and crashes. Switch to using
>> other functions to validate the address range.
>>
>> Tested-by: Dave Anderson <anderson@redhat.com>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> I took your previous comments as a tested by, please let me know if that
>> was wrong. This should probably just go through -mm. I don't think this
>> is necessary for stable but I can request it later if necessary.
> 
> I'm surprised.  "overflows and crashes" sounds rather serious??
> 

It's currently only seen on arm64 and it's not clear if anyone
wants to use that particular combination on a stable release.
I think a better phrase is "this is not urgent for stable".

Thanks,
Laura
