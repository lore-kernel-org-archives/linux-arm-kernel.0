From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Nov 2015 21:22:27 -0600
Subject: [PATCH v2] Documentation: dt: Add bindings for Secure-only devices
In-Reply-To: <CAFEAcA-JU=W2bHh4kUxuYFhehGi=WaE-tkoA82jRxen5t0a1EQ@mail.gmail.com>
References: <1447345490-29671-1-git-send-email-peter.maydell@linaro.org>
 <20151112213343.GA28588@rob-hp-laptop>
 <CAFEAcA-JU=W2bHh4kUxuYFhehGi=WaE-tkoA82jRxen5t0a1EQ@mail.gmail.com>
Message-ID: <CAL_Jsq+G8ObDqHKRG+ghN4gPaGMcSTUOp4W9-r4imzuF1W=RGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 3:42 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 November 2015 at 21:33, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Nov 12, 2015 at 04:24:50PM +0000, Peter Maydell wrote:
>>> The existing device tree bindings assume that we are only trying to
>>> describe a single address space with a device tree (for ARM, either
>>> the Normal or the Secure world). Some uses for device tree need to
>>> describe both Normal and Secure worlds in a single device tree. Add
>>> documentation of how to do this, by adding extra properties which
>>> describe when a device appears differently in the two worlds or when
>>> it only appears in one of them.
>>>
>>> The binding describes the general principles for adding new
>>> properties describing the secure world, but for now we only need a
>>> single new property, "secure-status", which can be used to annotate
>>> devices to indicate that they are only visible in one of the two
>>> worlds.
>>>
>>> The primary expected use of this binding is for a virtual machine
>>> like QEMU to describe the VM layout to a TrustZone aware firmware
>>> (which would then use the secure-only devices itself, and pass the DT
>>> on to a kernel running in the non-secure world, which ignores the
>>> secure-only devices and uses the rest).
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> I'd specifically like Mark's ack on this one.


>>> +The general principle of the naming scheme for Secure world bindings
>>> +is that any property that needs a different value in the Secure world
>>> +can be supported by prefixing the property name with "secure-". So for
>>> +instance "secure-reg" would override "reg". If there is no "secure-"
>>
>> I'd prefer this be "secure-foo" and "foo", rather than reg given I
>> specifically have a differing opinion on how to support reg.
>>
>> Also, would it be secure-vendor,foo or vendor,secure-foo for properties
>> with vendor prefix? The latter looks more correct to me, but the former
>> would be easier to search for both variants of the property. I'd lean
>> towards the latter.
>
> OK, so how about making that para read:
>
> + The general principle of the naming scheme for Secure world bindings
> + is that any property that needs a different value in the Secure world
> + can be supported by prefixing the property name with "secure-". So for
> + instance "secure-foo" would override "foo". For property names with
> + a vendor prefix, the Secure variant of "vendor,foo" would be
> + "vendor,secure-foo". If there is no "secure-" property then the Secure
> + world value is the same as specified for the Normal world by the
> + non-prefixed property. However, only the properties listed below may
> + validly have "secure-" versions; this list will be enlarged on a
> + case-by-case basis.

Looks good.

Rob
