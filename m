From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 1 Nov 2012 09:51:19 +0800
Subject: [PATCH V4 3/7] ARM: tegra30: cpuidle: add powered-down state
 for secondary CPUs
In-Reply-To: <CAMbhsRRT60oyecsZqjf196Y=Cog209TwfMCPJ9nyLG+fwu7mqg@mail.gmail.com>
References: <1351676481-28425-1-git-send-email-josephl@nvidia.com>
 <1351676481-28425-4-git-send-email-josephl@nvidia.com>
 <CAMbhsRRT60oyecsZqjf196Y=Cog209TwfMCPJ9nyLG+fwu7mqg@mail.gmail.com>
Message-ID: <1351734679.3231.64.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-01 at 05:19 +0800, Colin Cross wrote:
> On Wed, Oct 31, 2012 at 2:41 AM, Joseph Lo <josephl@nvidia.com> wrote:
> > This supports power-gated idle on secondary CPUs for Tegra30. The
> > secondary CPUs can go into powered-down state independently. When
> > CPU goes into this state, it saves it's contexts and puts itself
> > to flow controlled WFI state. After that, it will been power gated.
> >
> > Be aware of that, you may see the legacy power state "LP2" in the
> > code which is exactly the same meaning of "CPU power down".
> 
> On Tegra20, LP2 included powering off the GIC.  Is that still the case
> for Tegra30 individual secondary cpu power gating?  If so, how do IPIs
> to an idle cpu wake it up?

Hi Colin,

Thanks for your review.
For Tegra30, the LP2 of secondary CPU didn't power gate GIC. Only when 4
cores in LP2, the power of cpu cluster will be shut off that include
GIC. For the LP2 of individual secondary CPU, it can be woke up by IPI.

Thanks,
Joseph
