From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 16 Mar 2013 00:33:12 +0530
Subject: [PATCH V3 3/5] ARM: tegra:add aliases and DMA requestor for serial
 nodes of Tegra114
In-Reply-To: <51436F6C.1050901@wwwdotorg.org>
References: <1363204194-19487-1-git-send-email-ldewangan@nvidia.com>
 <1363204194-19487-4-git-send-email-ldewangan@nvidia.com>
 <5140DB61.3090809@wwwdotorg.org> <514367F3.6040909@wwwdotorg.org>
 <51436BAE.9080206@nvidia.com> <51436F6C.1050901@wwwdotorg.org>
Message-ID: <51437070.6080305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 March 2013 12:28 AM, Stephen Warren wrote:
> On 03/15/2013 12:42 PM, Laxman Dewangan wrote:
>>
>>
>>
>> Simple uart driver use the uart clock divider and it is fine here.
>>
>> High speed uart driver uses the car register driver for better
>> flexibility and better resolution.
> OK, so I see that Tegra30 has an enhancement over Tegra20. However,
> given your description, that enhancement is optional; a driver could
> simply continue to use /just/ the in-UART divider, and ignore the CAR
> divider, and still work just fine, albeit with (entirely
> backwards-compatible) less accuracy than it might achieve if it used the
> new feature.
>
> As such, I think it's correct to mark the device as actually being
> compatible with all 3: 114 (precise HW model), 30 (base model w/ extra
> divider), 20 (base model that's compatible, albeit ignoring extra features).
>
> That might be a bit excessive though, so I guess I'll just go with the
> values in your patch. It'd be a good idea if you could post a follow-on
> patch that updates the DT binding to explain this, and then removes the
> comments from *.dtsi since this really should be explained in the
> binding document not the .dtsi files, I think.
>
> At most, I'd expect to see the following in the .dtsi files:
>
> These nodes can either be compatible with nvidia,tegra114-uart, or
> nvidia,tegra114-hsuart. See the bindings for details of the difference.

Sure, I will post a patch for this.
