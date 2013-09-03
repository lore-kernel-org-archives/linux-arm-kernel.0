From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Sep 2013 12:36:06 -0600
Subject: [PATCH v4 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <CAAVeFuJ=z-29gp9=caQaxRGCiOQSnPLfafia3eCgWAUuny3GBg@mail.gmail.com>
References: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
 <1377770268-14014-2-git-send-email-acourbot@nvidia.com>
 <2081838.eZHRxlDf7s@flatron>
 <CAAVeFuJ=z-29gp9=caQaxRGCiOQSnPLfafia3eCgWAUuny3GBg@mail.gmail.com>
Message-ID: <52262C16.3020406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 01:28 AM, Alexandre Courbot wrote:
> Hi Tomasz!
> 
> On Fri, Aug 30, 2013 at 5:20 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> +Required properties:
>>> +- compatible : "tl,trusted-foundations"
>>> +- version-major : major version number of Trusted Foundations firmware
>>> +- version-minor: minor version number of Trusted Foundations firmware
>>
>> Hmm, maybe you could simply define a single version property that could
>> have multiple cells? Like:
>>
>>         firmware {
>>                 compatible = "tl,trusted-foundations";
>>                 version = <2 8>;
>>         };
> 
> I'm fine this way too, but do we have other bindings that use the same
> scheme? What is the general convention for version number bindings?

I don't know if there are enough cases of this for there to be a
convention. A 2-cell property seems fine to me.

>>> +       This option allows the kernel to invoke the secure monitor whenever
>>> +       required on devices using Trusted Foundations.
>>> +
>>> +       Devices using Trusted Foundations should pass a device tree
>>> containing +    a node compatible with "tl,trusted-foundations" to
>>> signal the presence +   of the secure monitor.
>>
>> What about pointing to the documentation file instead?
> 
> Yes, that would make more sense.

Possibly. What about when the binding document is no longer part of the
kernel though? Perhaps we could reference the documentation in some way
other than by the pathname within the kernel source tree though, e.g.
'see the device tree binding documentation for
compatible="tl,trusted-foundations"'?
