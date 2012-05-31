From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 May 2012 02:04:36 -0700
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <4FC73424.80107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/31/2012 12:51 AM, Peter De Schrijver wrote:
> On Wed, May 30, 2012 at 10:52:31AM +0200, Stephen Boyd wrote:
>> On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
>>> Add an extension API for clocks. This allows clocktypes to provide extensions
>>> for features which are uncommon and cannot be easily mapped onto normal clock
>>> framework concecpts. eg: resetting blocks, configuring clock phase etc.
>> This seems rather generic. Why not add more specific APIs/concepts like
>> clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
>> make them map.
>>
> Some of those might be very SoC specific. Eg OMAP doesn't need software
> controlled modulereset. I don't think we should add a new function to the
> clock framework for clock related features which only exist in a single
> SoC or family. Ideally we could use inheritance to add methods to derived
> clocktypes, but that's not really possible in C unfortunately.

Most likely your hardware is not that special and the functionality you
think exists only on your SoC actually exists on 5 others. MSM needs
software resets too and we also associate them with each clock (there
can be many clocks for one device and one reset for each clock). We use
them mostly for the power domain code (looks like tegra and omap do the
same thing albeit slightly differently).

What do you plan to support under this API?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
