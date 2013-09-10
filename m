From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Sep 2013 14:04:31 +0100
Subject: [PATCH v5 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <CAAVeFu+MGGBfmm1jwtKGP_d3EjkLdf5B_E_5RT___PVh1e=8jw@mail.gmail.com>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
 <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
 <5228CEDB.1090306@gmail.com>
 <CAAVeFu+MGGBfmm1jwtKGP_d3EjkLdf5B_E_5RT___PVh1e=8jw@mail.gmail.com>
Message-ID: <20130910130431.GE27966@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Mon, Sep 09, 2013 at 07:15:31AM +0100, Alexandre Courbot wrote:
> On Fri, Sep 6, 2013 at 3:35 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 09/04/2013 10:27 PM, Alexandre Courbot wrote:
> >> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> >> can be invoked  using a consistent SMC-based API on all supported
> >> platforms. This patch adds initial basic support for Trusted
> >> Foundations using the ARM firmware API. Current features are limited
> >> to the ability to boot secondary processors.

[...]

> >> +Example:
> >> +     firmware {
> >> +             compatible = "tl,trusted-foundations";
> >> +             version-major = <2>;
> >> +             version-minor = <8>;
> >> +     };
> >
> > I'm wondering how we fit this in with PSCI bindings? Both are pieces of
> > firmware functionality and may co-exist. There's nothing incompatible
> > here, but there should be some commonality. Will future versions of
> > Trusted Foundations follow the SMC calling conventions doc? What about
> > armv8 support.
> 
> I don't have any information about the future of TF unfortunately,
> excepted that it should remain backward-compatible. What is this SMC
> calling convention doc your are talking about btw? Is there a standard
> calling convention defined by ARM?

SMC calling convention:

https://silver.arm.com/download/download.tm?pv=1435186

PSCI:

https://silver.arm.com/download/download.tm?pv=1421585

Although access to these documents requires you to go through a
click-through license.

Will
