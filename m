From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Oct 2016 09:57:35 +0100
Subject: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
In-Reply-To: <7hh980taqp.fsf@baylibre.com>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
 <7hh980taqp.fsf@baylibre.com>
Message-ID: <68dc67d1-b443-f7b1-6229-0ac54e403d61@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/10/16 21:49, Kevin Hilman wrote:
> Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Update domain-idle-state binding to use "domain-idle-state" compatible
>> from Documentation/devicetree/bindings/arm/idle-states.txt.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> With no current users for this, I don't see the point of adding a
> compatible now.
>
> IMO, this should wait and be added with the identified user we can
> discuss it then.
>

No, IMO it needs to be used for the proposed SoC idle/genpd solution.

I understand the nodes that are "arm,idle-state" compatible can be used
for this new SoC hierarchical idle management, but it was never defined
for that use originally. So this new feature must be advertised by the 
firmware with the presence of "domain-idle-state".

Yes we might have other ways to detect that but I have already seen that 
broken on the reference platform, so we need alternate/DT way to specify 
that.

Not all existing "arm,idle-state" compatible nodes will be capable of
supporting this new SoC idle feature. It's just better and safer for a
new feature getting added that relies on DT to have a new compatible.

-- 
Regards,
Sudeep
