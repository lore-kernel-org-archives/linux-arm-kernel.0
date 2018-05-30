From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 30 May 2018 14:32:12 +0200
Subject: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
 <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
Message-ID: <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 6:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-05-18, 15:18, Krzysztof Kozlowski wrote:
>> Thanks for the patch.
>>
>> In case of Exynos, the booting CPU always has these information in DT
>> and the booting CPU cannot be changed (chosen by firmware/hardware
>> configuration).
>
> But can the booting CPU be offlined ?
>
> If yes, then this is how things are broken right now.
>
> Build cpufreq driver as module, boot kernel, hotplug out CPU0, insert
> cpufreq driver and that will try to find these properties in CPU1.

OK, I see the possibility although it is still far away from use
cases. You cannot hotplug booting CPU (CPU0) on Exynos kernels. It
never worked. Strictly speaking - offlining will work. But bringing it
online will likely hang the system.

Best regards,
Krzysztof
