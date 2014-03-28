From: charles.garcia-tobin@arm.com (Charles Garcia-Tobin)
Date: Fri, 28 Mar 2014 15:40:04 -0000
Subject: [Linaro-acpi] [PATCH v3 1/3] PSCI: Add initial support
 for	PSCIv0.2 functions
In-Reply-To: <CAJ5Y-eaugzMAByxacsr7cO7T0vXPHqdBtSTXKjVQfNLHAMJV-Q@mail.gmail.com>
References: <1395955430-26050-1-git-send-email-ashwin.chaugule@linaro.org>
 <1395955430-26050-2-git-send-email-ashwin.chaugule@linaro.org>
 <CABGGisyMn6uuFOwcS3AfBX3c85fwore_TeBq68opmJqQPyR7wQ@mail.gmail.com>
 <CAJ5Y-eaugzMAByxacsr7cO7T0vXPHqdBtSTXKjVQfNLHAMJV-Q@mail.gmail.com>
Message-ID: <001301cf4a9b$fdff0a50$f9fd1ef0$@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linaro-acpi-bounces at lists.linaro.org [mailto:linaro-acpi-
> bounces at lists.linaro.org] On Behalf Of Ashwin Chaugule
> Sent: 28 March 2014 15:00
> To: rob.herring at linaro.org
> Cc: Anup Patel; Patch Tracking; Marc Zyngier; linaro-acpi;
linux-arm-kernel;
> Christoffer Dall
> Subject: Re: [Linaro-acpi] [PATCH v3 1/3] PSCI: Add initial support for
PSCIv0.2
> functions
> 
> Hi Rob,
> 
> On 28 March 2014 09:54, Rob Herring <rob.herring@linaro.org> wrote:
> 
> >> +#define PSCI_VER_MAJOR_MASK            0xffff0000
> >> +#define PSCI_VER_MINOR_MASK            0x0000ffff
> >> +#define PSCI_VER_MAJOR_SHIFT   16
> >> +#define PSCI_VER_MAJOR(ver)            \
> >> +       ((ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT)
> >> +#define PSCI_VER_MINOR(ver)            (ver & PSCI_VER_MINOR_MASK)
> >
> > This can go in the header.
> 
> Will do.
> 
> >
> > [snip]
> >
> >> +       ver = psci_get_version();
> >> +
> >> +       pr_info("PSCIv%d.%d detected in firmware.\n",
PSCI_VER_MAJOR(ver),
> >> +                       PSCI_VER_MINOR(ver));
> >> +
> >> +       if (PSCI_VER_MAJOR(ver) == 0 && PSCI_VER_MINOR(ver) < 2) {
> >
> > So we want to allow 0.3, but not 1.x? I think we want to allow any
> > later version. Later versions either have to be backward's compatible
> > with 0.2 or have to not have "arm,psci-0.2" compatible string.
> 
> If its 1.x, it should still go through? Should only fail for 0.1 or 0.0.
> 
> >
> > Does this work if ver is an error value? We may have implementations
> > that failed to implement this function (which should not be ignored
> > for now).
> 
> True. What is a good err value to check for? negative values?
> 
> One would hope implementations would return (-7) NOT_PRESENT, but it
> could also be garbage?

So from v0.2 PSCI_VERSION is compulsory. It has to be implemented. If a
function is not implemented it must return NOT_SUPPORTED(-1)

Cheers

Charles

>
> >> + *
> >> + *     Copyright (C) 2014, Ashwin Chaugule
<ashwin.chaugule@linaro.org>
> >
> > I believe this should be:
> >
> > Copyright (C) 2014 Linaro Ltd.
> > Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >
> > And typically the copyright is placed above the license.
> 
> Ok.
> 
> >> +
> >> +#define PSCI_RET_SUCCESS               0
> >> +#define PSCI_RET_EOPNOTSUPP            -1
> >> +#define PSCI_RET_EINVAL                        -2
> >> +#define PSCI_RET_EPERM                 -3
> >
> > Please fill out all error codes.
> >
> 
> Ok, I see the return codes table. Will add all of it.
> 
> Cheers,
> Ashwin
> 
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-acpi
