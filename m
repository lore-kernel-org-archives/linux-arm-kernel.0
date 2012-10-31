From: ccross@google.com (Colin Cross)
Date: Wed, 31 Oct 2012 14:19:22 -0700
Subject: [PATCH V4 3/7] ARM: tegra30: cpuidle: add powered-down state for
 secondary CPUs
In-Reply-To: <1351676481-28425-4-git-send-email-josephl@nvidia.com>
References: <1351676481-28425-1-git-send-email-josephl@nvidia.com>
 <1351676481-28425-4-git-send-email-josephl@nvidia.com>
Message-ID: <CAMbhsRRT60oyecsZqjf196Y=Cog209TwfMCPJ9nyLG+fwu7mqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 2:41 AM, Joseph Lo <josephl@nvidia.com> wrote:
> This supports power-gated idle on secondary CPUs for Tegra30. The
> secondary CPUs can go into powered-down state independently. When
> CPU goes into this state, it saves it's contexts and puts itself
> to flow controlled WFI state. After that, it will been power gated.
>
> Be aware of that, you may see the legacy power state "LP2" in the
> code which is exactly the same meaning of "CPU power down".

On Tegra20, LP2 included powering off the GIC.  Is that still the case
for Tegra30 individual secondary cpu power gating?  If so, how do IPIs
to an idle cpu wake it up?
