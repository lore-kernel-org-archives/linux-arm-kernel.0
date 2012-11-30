From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 30 Nov 2012 17:54:33 +0530
Subject: [PATCH v8 2/2] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <4963449.bQgUShLPPx@amdc1227>
References: <1352888836-17192-1-git-send-email-p.paneri@samsung.com>
 <1433031.3ftjAfsj34@flatron>
 <CAD6zSYMNSX8ASPBLpft-0riBi-xeD_b=BjCjSrftX_5_F2+TDA@mail.gmail.com>
 <4963449.bQgUShLPPx@amdc1227>
Message-ID: <CAD6zSYO+DiDaKJ=a3V97yDLeNFmyfFFiNp9ba8iA-pgcF5fj=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 6:50 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Praveen,
>
> On Friday 23 of November 2012 09:54:51 Praveen Paneri wrote:
>> We will anyway remove the platform data part soon. If you say I can
>> resend it again.
>
> I think that the requirement for platform data on DT-enabled systems
> should be removed before this series get merged, because there are already
> patches being worked on to remove auxdata tables (common clock framework
> support by Thomas Abraham).
Next is to add support for 4210, 4x12 and Exynos5 (patches were sent
by vivek Gautam already). Not only s3c-hsotg but ehci, ohci and dwc
will start using phy driver.
This will remove phy related platform data passed to these drivers and...
>
> Adding next auxdata entry (containing platform data that must be provided)
> would make them depend on phy platform data removal patch, which would
> complicate things.
s3c-hsotg platform data is also passing "is_osc" (Clock source info)
and "dma" (dma mode info) from platform_data. IT seems they both are
not used as on now. May be Lukasz can tell if we can move that to
config option and get rid of s3c-hsotg_plat completely.

Once that is done only AUXDATA entry, which will be remaining, will be
that of phy driver and I understand that we have to work towards
removal of that as well but I guess this is a good first step towards
the goal.

>
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Linux Platform
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
