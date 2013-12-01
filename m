From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 01 Dec 2013 12:06:49 -0700
Subject: [PATCH 02/31] ARM: tegra: document reset properties in DT bindings
In-Reply-To: <20131129122348.GO22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
 <20131129122348.GO22771@ulmo.nvidia.com>
Message-ID: <529B88C9.60804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 05:23 AM, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:53:57PM -0700, Stephen Warren wrote: 
> [...]
>> diff --git
>> a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
>> b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
>
>> 
[...]
>> +  - resets : Must contain an entry for each entry in
>> reset-names. +    See ../reset/reset.txt for details. +  -
>> reset-names : Must include the following entries: +    - dc
> 
> For consistency with this, the clock-names entry for the first
> clock in this node should then be "dc" as well.

The dc driver gets the clock by name, so this isn't a requirement.

>> diff --git
>> a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
>> b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
>
>> 
[...]
>> -  - spdif_in +  - spdif
> 
> Why is this renamed?

There are two separate clocks for the SPDIF input and output modules,
but just a single reset.
