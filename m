From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 3 Feb 2016 12:16:29 +0000
Subject: [PATCH v1 4/5] arm64: cpufeature: Test 'matches' pointer to find
 the end of the list
In-Reply-To: <1454432611-21333-5-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
 <1454432611-21333-5-git-send-email-james.morse@arm.com>
Message-ID: <56B1EF9D.9060803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 17:03, James Morse wrote:
> CPU feature code uses the desc field as a test to find the end of the list,
> this means every entry must have a description. This generates noise for
> entries in the list that aren't really features, but combinations of them.
> e.g.
>> CPU features: detected feature: Privileged Access Never
>> CPU features: detected feature: PAN and not UAO
>
> These combination features are needed for corner cases with alternatives,
> where cpu features interact.
>
> Change all walkers of the arm64_features[] and arm64_hwcaps[] lists to test
> 'matches' not 'desc', and only print 'desc' if it is non-NULL.

Makes sense.

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>

Cheers
Suzuki
