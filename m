From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 14:03:28 -0800
Subject: [PATCH 0/4] ARM: tegra: Automatic UART selection for earlyprintk
In-Reply-To: <CAD=FV=WE51BbXdkQ9zjVCR_vjuHR5qn0YR+RteL-Q30bZ59BCA@mail.gmail.com>
References: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
 <CAD=FV=X8p5RXKc0CW4KYzmoCw7tkOrahD2tnqKfXqqRR6MEAJQ@mail.gmail.com>
 <CAD=FV=WE51BbXdkQ9zjVCR_vjuHR5qn0YR+RteL-Q30bZ59BCA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F180C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote at Wednesday, January 04, 2012 4:48 PM:
...
> 2. I'm slightly concerned about cramming stuff into IRAM, since
> ? ?I don't have a good concept of what IRAM adresses are used when.
> ? ?When I grep for IRAM users in our kernel, I see
> ? ?TEGRA_AVP_RESUME_ADDR is using the base of IRAM. ?We're not going
> ? ?to be hosing suspend/resume or anything else with this CL, are we?
> ? ?In the very least, I'd perfer to see a #define for the '0x100' and
> ? ?the '0x55415254' so that we can correlate the constants in
> ? ?uncompress.h and debug-macro.S

I discussed this with a few people, and it sounds like it's safe to use
IRAM for this. However, I did discover a few other uses of IRAM too, in
our downstream kernels anyway, so I'll certainly create arch/arm/mach-
tegra/include/mach/irammap.h that provides defines for all the IRAM
offsets, what they're used for, and when.

-- 
nvpublic
