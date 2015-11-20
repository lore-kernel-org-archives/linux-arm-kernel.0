From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 20 Nov 2015 13:37:00 +0000
Subject: [PATCH 2/5] arm64: cpufeature: Track unsigned fields
In-Reply-To: <20151119184533.GB10823@e104818-lin.cambridge.arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-2-git-send-email-suzuki.poulose@arm.com>
 <564D56CA.60502@linaro.org> <564D9E61.8010802@arm.com>
 <20151119184533.GB10823@e104818-lin.cambridge.arm.com>
Message-ID: <564F21FC.1030306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/15 18:45, Catalin Marinas wrote:
> On Thu, Nov 19, 2015 at 10:03:13AM +0000, Suzuki K. Poulose wrote:
>> On 19/11/15 04:57, AKASHI Takahiro wrote:


> a) A precise value (number of breakpoint registers) or a value from
>     which you derive some precise value. You mentioned these above
>
> b) Fields defining the presence of a feature (1, 2, 3). These would
>     always be positive since the absence of such feature would mean a
>     value of 0
>
> c) Fields defining the absence of a feature by setting 0xf. These are
>     usually fields that were initial RAZ and turned to -1. I don't expect
>     such field be greater than 0, nor smaller than -1.
>
> So I think we can treat (a) and (b) as unsigned permanently.

Agreed.

> We could treat (c) as unsigned as well with a value of 0xf though I'm not sure
> how it matches your LOWER/HIGHER_SAFE definitions.

I think we should treat (c) as signed, as we never know what could change,
given that meaning of (0xf - implies unsupported) < meaning of (0 - supported).
Treating them unsigned could break the LOWER/HIGHER_SAFE definitions and makes
the safe value selection ugly.

Cheers
Suzuki
