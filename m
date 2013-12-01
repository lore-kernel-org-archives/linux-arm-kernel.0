From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 01 Dec 2013 12:21:17 -0700
Subject: [PATCH 1/5] clk: tegra: fix blink clock rate
In-Reply-To: <20131129152241.GM9712@ulmo.nvidia.com>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
 <20131129152241.GM9712@ulmo.nvidia.com>
Message-ID: <529B8C2D.3000300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 08:22 AM, Thierry Reding wrote:
> On Wed, Nov 20, 2013 at 04:47:18PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> The blink clock rate needs to be configured, or it will run at
>> ~1Hz rather than the desired 32KHz. If it runs at the wrong rate,
>> e.g. the SDIO WiFi on Seaboard and Cardhu will fail to be
>> detected.
> 
> How is this related to WiFi?

The "blink" clock output from Tegra is connected to the WiFi module,
which then uses it for something; it probably has a PLL connected to
it that drives all the internal circuitry.
