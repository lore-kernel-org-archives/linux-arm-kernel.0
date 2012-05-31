From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 May 2012 10:42:09 -0600
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4FC79F61.6030907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2012 03:58 AM, Peter De Schrijver wrote:
> Add an extension API for clocks. This allows clocktypes to provide extensions
> for features which are uncommon and cannot be easily mapped onto normal clock
> framework concecpts. eg: resetting blocks, configuring clock phase etc.

I'm not sure that we should expose module reset as an operation on a clock.

In Tegra, there are resets that affect multiple clocks (well, they
affect portions of HW that use multiple clocks, not the clocks themselves).

Conversely, it's possible in general that there could be some clock
domains where different subsets of the clock domain are affected by
different reset domains.

Tieing the clock and reset domains together doesn't seem correct. A
separate reset API (and perhaps reset binding for DT) might make more sense.
