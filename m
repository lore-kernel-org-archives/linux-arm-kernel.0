From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 08:09:42 -0700
Subject: [PATCH v2 2/8] arm/tegra: prepare early init for multiple tegra
	variants
In-Reply-To: <20111103100235.GK12913@n2100.arm.linux.org.uk>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-3-git-send-email-pdeschrijver@nvidia.com>
	<CAMbhsRSTcR8qgYESmM6OxkXeVeg6vS49woCe_OX6CY4pAj2g_A@mail.gmail.com>
	<20111103092116.GO13358@tbergstrom-lnx.Nvidia.com>
	<20111103100235.GK12913@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMh7LqUtBkB5Dffr-bJSkC__V+55yLsp7KAYs-6oRAGMhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2011 at 3:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Nov 03, 2011 at 11:21:16AM +0200, Peter De Schrijver wrote:
>> On Wed, Nov 02, 2011 at 07:30:43PM +0100, Colin Cross wrote:
>> > On Wed, Nov 2, 2011 at 7:09 AM, Peter De Schrijver
>> > <pdeschrijver@nvidia.com> wrote:
>> > > This patch splits the early init code in a common and a tegra20 specific part.
>> > > L2 cache initialization is generalized and discovers the cache associativity
>> > > at runtime.
>> > >
>> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> > > ---
>> > <snip>
>> >
>> > > -static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
>> > > +void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
>> > > +
>> > This is unrelated to the patch description?
>> >
>>
>> This is a left over from the past. Will be removed from the next version.
>
> Please can Tegra move over to hooking the restart via arm_pm_restart()
> rather than via arch_reset()? ?That would leave arch_reset() for
> software-based reboot methods - which I suspect Tegra doesn't use.
>
> That would allow Tegra to dovetail into the arch_reset cleanup work much
> better than it would otherwise do.

Sounds reasonable to me. Want a patch to put in your arch_reset
cleanup branch, I presume? I'll post something later today.


-Olof
