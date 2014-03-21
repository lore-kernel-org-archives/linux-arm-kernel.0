From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 21 Mar 2014 08:49:19 -0400
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <20140321105152.GL23372@e106331-lin.cambridge.arm.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <20140320145742.GF23372@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eYwMKXWiuAx_Kbv8XJ2Ym_jbStuNaNjtWe1RP8Xz+j-Rg@mail.gmail.com>
 <20140321105152.GL23372@e106331-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-eb-rmccCskWvFz7Z7o-pWa8iuuDhk1bJxegY7Kgbpgbfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2014 06:51, Mark Rutland <mark.rutland@arm.com> wrote:

>> The main intention of this patch is to separate function ID detection
>> depending on PSCI versions.
>> So, I think the additional functionality of AFFINITY_INFO and
>> MIGRATE_INFO_TYPE should go in as separate patches. Do you agree?
>
> Unfortunately this has the side effect of seemingly adding support for
> PSCI 0.2 while not actually doing so. I fear that people will begin
> using the "arm,psci-0.2" string before we end up implementing code using
> the other required functionality, and it will turn out we can't make use
> of any of it, because it will cause someone's firmware to blow up.

Ah. I've only seen PSCI-v0.2. Didnt know that this stuff was part of
the new additions to the spec.

Ashwin
