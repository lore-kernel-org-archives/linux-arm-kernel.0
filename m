From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 22 Feb 2016 11:37:42 +0000
Subject: [PATCH 6/6] arm64: compat: Check for AArch32 state
In-Reply-To: <20160209173606.GX22874@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
 <1453980737-6126-7-git-send-email-suzuki.poulose@arm.com>
 <20160209173606.GX22874@arm.com>
Message-ID: <56CAF306.1060102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 17:36, Will Deacon wrote:
> On Thu, Jan 28, 2016 at 11:32:17AM +0000, Suzuki K Poulose wrote:
>> Make sure we have AArch32 state available for running COMPAT binaries.


>>   		 */
>>   		seq_puts(m, "Features\t:");
>> -		if (personality(current->personality) == PER_LINUX32) {
>> +		if (system_supports_32bit_el0() &&
>> +			personality(current->personality) == PER_LINUX32) {
>
> Wouldn't it be better to prevent tasks changing to the PER_LINUX32
> personality on systems that don't support AArch32 at EL0?

Yes, thats the ideal solution. I took a look at it  and it requires us to
hook in arm64 wrapper for the personality syscall. I will take a look.

Thanks
Suzuki
