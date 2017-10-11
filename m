From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Oct 2017 13:37:25 +0100
Subject: [PATCH v2] arm64: Expose support for optional ARMv8-A features
In-Reply-To: <20171011123705.GE11106@arm.com>
References: <20171010095310.30115-1-suzuki.poulose@arm.com>
 <20171010143530.fiomo7pqvtojflnn@localhost> <20171011123705.GE11106@arm.com>
Message-ID: <ab74bf7a-9ffd-ed5c-f8d9-6dbc89ca1791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/17 13:37, Will Deacon wrote:
> On Tue, Oct 10, 2017 at 03:35:30PM +0100, Catalin Marinas wrote:
>> On Tue, Oct 10, 2017 at 10:53:10AM +0100, Suzuki K. Poulose wrote:
>>> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
>>> index 4b9344cba83a..a4bad90a3fa3 100644
>>> --- a/arch/arm64/include/uapi/asm/hwcap.h
>>> +++ b/arch/arm64/include/uapi/asm/hwcap.h
>>> @@ -36,5 +36,10 @@
>>>   #define HWCAP_FCMA		(1 << 14)
>>>   #define HWCAP_LRCPC		(1 << 15)
>>>   #define HWCAP_DCPOP		(1 << 16)
>>> +#define HWCAP_SHA3		(1 << 17)
>>> +#define HWCAP_SM3		(1 << 18)
>>> +#define HWCAP_SM4		(1 << 19)
>>> +#define HWCAP_ASIMDDP		(1 << 20)
>>> +#define HWCAP_SHA512		(1 << 21)
>>
>> We may be getting some conflicts around these with additional patches
>> coming in but not hard to solve. Anyway, whether we are getting pointer
>> authentication in or not (probably the latter), I would really like to
>> get the first patch in that series merged:
>>
>> http://lkml.kernel.org/r/1500480092-28480-2-git-send-email-mark.rutland at arm.com
> 
> Suzuki -- can you take Mark's patch above and update the documentation to
> include the new hwcaps you've added, please?

Sure, will do that.

Cheers
Suzuki
