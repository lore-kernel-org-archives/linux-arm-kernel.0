From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 13 Jan 2014 17:16:41 -0800
Subject: [PATCH v10 4/4] arm64: topology: Provide relative power numbers
 for cores
In-Reply-To: <1389287106-29979-5-git-send-email-broonie@kernel.org>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-5-git-send-email-broonie@kernel.org>
Message-ID: <52D48FF9.1070501@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/09/2014 09:05 AM, Mark Brown wrote:
> The power numbers are the same as for ARMv7 since it seems that the
> expected differential between the big and little cores is very similar on
> both ARMv7 and ARMv8. These numbers are just an initial and basic
> approximation for use with the current scheduler, it is likely that both
> experience with silicon and ongoing work on improving the scheduler will
> lead to further tuning. In both ARMv7 and ARMv8 cases the numbers were
> based on the published DMIPS numbers.

Just to chime in on this.

As I think someone else proposed, ideally both arch/arm32 and arch/arm64 
should be determining these metrics dynamically, and allowing the 
metrics to be overridden from DT data.  These metrics can vary 
significantly based on variables other than just the core type.

For example, for some ARMv7 CPUs, we know that different revision levels 
of the same core type can result in significant performance 
differences.  Also CPU bug workarounds applied early by the bootloader, 
or different integrator hardware core configurations, can impact these 
metrics.


- Paul
