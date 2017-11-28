From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 28 Nov 2017 11:40:05 +0000
Subject: [question] extract the feature bits width to 4
In-Reply-To: <17ab0a11-7ca2-ff22-35d6-7446dbccc3ea@huawei.com>
References: <17ab0a11-7ca2-ff22-35d6-7446dbccc3ea@huawei.com>
Message-ID: <f9d9af3e-e7c0-88fe-156e-a7969ca7394f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-arm-kernel

On 28/11/17 11:17, gengdongjiu wrote:
> Hi,suzuki/mark,

Hello!

Please Cc linux-arm-kernel mailing list in the future for any arm/arm64 kernel
related queries.

> 
>    very sorry to disturb you, I have a question that want to consult with you. For the CPU feature detection,
> why we use extract 4 bits width for the feature match instead of the actual bits number[1]?  may be the actual hardware feature bit more than 4 bits.


There are features which could be more or less than 4bit wide. However,
all the arm64_cpu_capabilities features are 4bits and hence the hard coded
bits there. If we ever come across handling capabilities which are not
standard size, we could add the necessary code to support it.

Are you planning to add something which does require the change ? Please
feel free to send patches.

Cheers

Suzuki


> thanks!
> 
> static inline int __attribute_const__
> cpuid_feature_extract_field(u64 features, int field, bool sign)
> {
>          return cpuid_feature_extract_field_width(features, field, 4, sign);
> }
> 
> static bool
> feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
> {
>          int val = cpuid_feature_extract_field(reg, entry->field_pos, entry->sign);
> 
>          return val >= entry->min_field_value;
> }
> 
> 
