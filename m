From: cjb@laptop.org (Chris Ball)
Date: Mon, 27 Aug 2012 18:28:35 -0400
Subject: [PATCH] mmc: tegra: convert to device tree support only
In-Reply-To: <1345772433.5081.1.camel@jlo-ubuntu-64.nvidia.com> (Joseph Lo's
 message of "Fri, 24 Aug 2012 09:40:33 +0800")
References: <1345187071-6619-1-git-send-email-josephl@nvidia.com>
 <502E950B.2010205@wwwdotorg.org>
 <1345772433.5081.1.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <87a9xgynos.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 23 2012, Joseph Lo wrote:
> On Sat, 2012-08-18 at 03:01 +0800, Stephen Warren wrote:
>> On 08/17/2012 01:04 AM, Joseph Lo wrote:
>> > When compiling a kernel that supports only Tegra30 and not Tegra20,
>> > the SDHCI driver will fail to compile since the of_match_device() failure
>> > fallback code unconditinally references soc_data_tegra20, which is only
>> > compiled in when Tegra20 support is enabled.
>> > 
>> > In Kernel 3.7, both Tegra20 and Tegra30 will only support booting using
>> > device tree, Hence, there is never a need to fall back to using
>> > soc_data_tegra20 if of_mach_device() fails. Instead, make this case an
>> > error. This removes the reference to soc_data_tegra20, and hence solves
>> > the compile failure.
>> 
>> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
>> 
>> (built and tested both Tegra20-only and Tegr30-only kernels with this
>> applied on top of next-20120816).
>
> Ping.

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
