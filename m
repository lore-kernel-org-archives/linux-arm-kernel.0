From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 15:42:21 -0600
Subject: [PATCH] clk: add table lookup to mux
In-Reply-To: <20130319213309.8663.17375@quantum>
References: <1363113747-6572-1-git-send-email-pdeschrijver@nvidia.com>
 <20130319213309.8663.17375@quantum>
Message-ID: <5148DBBD.8020506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 03:33 PM, Mike Turquette wrote:
> Quoting Peter De Schrijver (2013-03-12 11:42:23)
>> Add a table lookup feature to the mux clock. Also allow arbitrary masks
>> instead of the width. This will be used by some clocks on Tegra114. Also
>> adapt the tegra periph clk because it uses struct clk_mux directly.
>>
>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Do you actually need arbitrary masks instead of a continuous bitfield?
> Or does this change just make it easier for you to convert existing
> data?

Yes, Peter mentioned somewhere that Tegra apparently has some registers
where the mux bits are split up into non-contiguous regions of a register.
