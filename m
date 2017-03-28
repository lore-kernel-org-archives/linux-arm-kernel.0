From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Mar 2017 17:49:41 +0100
Subject: [PATCH] arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210
 platforms
In-Reply-To: <9069e2fd-bf7b-b1df-3d1b-071ee21642ef@wwwdotorg.org>
References: <1490701718-16571-1-git-send-email-jonathanh@nvidia.com>
 <9069e2fd-bf7b-b1df-3d1b-071ee21642ef@wwwdotorg.org>
Message-ID: <f9c59c65-de48-108d-73df-c659cc3300e6@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/03/17 17:23, Stephen Warren wrote:
> On 03/28/2017 05:48 AM, Jon Hunter wrote:
>> Add the CPU and PSCI nodes for the NVIDIA Tegra210 platforms so that
>> all CPUs can be enabled on boot. This assumes that the PSCI firmware
>> has been loaded during the initial bootstrap on the device before the
>> kernel starts (which is typically the case for these platforms). The
>> PSCI firmware version is set to v0.2 which aligns with the current
>> shipping version for Tegra.
> 
> This seems fine, although I'd expect PSCI to be used everywhere on
> Tegra, so putting this in tegra210.dtsi would make more sense.

It's fine with me. Although technically, tegra210-smaug ships with
psci-v1.0 and tegra210-jetson-tx1 currently have psci-v0.2. However, I
did test both with the psci version set to v1.0 and the jetson-tx1, did
detect the version automatically and reverted to v0.2 (which is a
feature of psci >= v0.2). For Tegra186 we also have the psci node in the
tegra186-p3310.dtsi.

Jon

-- 
nvpublic
