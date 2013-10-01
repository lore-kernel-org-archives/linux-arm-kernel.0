From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 01 Oct 2013 10:09:56 +0800
Subject: [PATCH 1/2] ARM: include: asm: use 'long long' instead of 'u64'
 within atomic.h
In-Reply-To: <20130930160752.GH26036@mudshark.cambridge.arm.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
 <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
 <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
 <20130930160752.GH26036@mudshark.cambridge.arm.com>
Message-ID: <524A2EF4.70406@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 12:07 AM, Will Deacon wrote:
> On Sun, Sep 29, 2013 at 04:43:54AM +0100, Chen Gang wrote:
>> atomic* value is signed value, and atomic* functions need also process
>> signed value (parameter value, and return value), so 32-bit arm need
>> use 'long long' instead of 'u64'.
>>
>> After replacement, it will also fix a bug for atomic64_add_negative():
>> "u64 is never less than 0".
>>
>> The modifications are:
>>
>>   in vim, use "1,% s/\<u64\>/long long/g" command.
>>   remove '__aligned(8)' which is useless for 64-bit.
>>   be sure of 80 column limitation after replacement.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will
> 
> 

Thanks.

-- 
Chen Gang
