From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 09:38:54 -0700
Subject: [PATCH 2/2] clk: tegra: adapt tegra periph clk to mux table/mask
In-Reply-To: <20130129095158.GS4118@tbergstrom-lnx.Nvidia.com>
References: <1359388467-32386-1-git-send-email-pdeschrijver@nvidia.com>
 <1359388467-32386-3-git-send-email-pdeschrijver@nvidia.com>
 <5106AC31.1040207@wwwdotorg.org>
 <20130129095158.GS4118@tbergstrom-lnx.Nvidia.com>
Message-ID: <5107FB1E.3010907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 02:51 AM, Peter De Schrijver wrote:
> On Mon, Jan 28, 2013 at 05:49:53PM +0100, Stephen Warren wrote:
>> On 01/28/2013 08:54 AM, Peter De Schrijver wrote:
>>> The tegra peripheral clock type uses struct clk_mux directly, so it needs to
>>> be updated to handle the new mask and table fields. Also the macros need
>>> to be updated
>>
>> Just a quick note on patch dependencies here:
>>
>> Patch 1/2 can presumably be taken through the clk tree whenever Mike is
>> OK with it.
>>
>> Patch 2/2 depends on patches in the Tegra tree for 3.9. Since patch 2/2
>> is useful mostly for the Tegra114 clock driver, and I don't imagine that
>> will get posted/merged in time for 3.9, it's probably easiest to just
>> take patch 2/2 for 3.10 along with the Tegra114 clock driver. Also, I
>> imagine there won't be any more clk/Tegra tree dependencies in 3.10, so
>> patch 2/2 and the Tegra114 clk driver patches can likely go through the
>> clk tree itself for 3.10.
> 
> No. Because 1/2 changes struct clk_mux and the tegra peripheral clock type 
> uses struct clk_mux directly, 2/2 needs to be applied together with 1/2, even
> if the new functionality is not yet used.

Oh, then they can't be two separate patches then, or "git bisect" won't
work. I guess it's best to wait for 3.10 for this:-(
