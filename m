From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 2 Sep 2013 16:28:36 +0900
Subject: [PATCH v4 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <2081838.eZHRxlDf7s@flatron>
References: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
 <1377770268-14014-2-git-send-email-acourbot@nvidia.com>
 <2081838.eZHRxlDf7s@flatron>
Message-ID: <CAAVeFuJ=z-29gp9=caQaxRGCiOQSnPLfafia3eCgWAUuny3GBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz!

On Fri, Aug 30, 2013 at 5:20 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> +Required properties:
>> +- compatible : "tl,trusted-foundations"
>> +- version-major : major version number of Trusted Foundations firmware
>> +- version-minor: minor version number of Trusted Foundations firmware
>
> Hmm, maybe you could simply define a single version property that could
> have multiple cells? Like:
>
>         firmware {
>                 compatible = "tl,trusted-foundations";
>                 version = <2 8>;
>         };

I'm fine this way too, but do we have other bindings that use the same
scheme? What is the general convention for version number bindings?

>> +       This option allows the kernel to invoke the secure monitor
> whenever
>> +       required on devices using Trusted Foundations.
>> +
>> +       Devices using Trusted Foundations should pass a device tree
>> containing +    a node compatible with "tl,trusted-foundations" to
>> signal the presence +   of the secure monitor.
>
> What about pointing to the documentation file instead?

Yes, that would make more sense.

>> +void of_register_trusted_foundations(void)
>> +{
>> +     struct device_node *node;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "tl,trusted-
> foundations");
>
> nit:
>         if (!node)
>                 return;

Fixed, thanks.

>> +static inline void register_trusted_foundations(
>> +                                struct
> trusted_foundations_platform_data *pd)
>> +{
>> +     pr_crit("No support for Trusted Foundations, stopping...\n");
>> +     BUG();
>
> Hmm, why not simply panic()?

Fixed that too.

Thanks for the review!
Alex.
