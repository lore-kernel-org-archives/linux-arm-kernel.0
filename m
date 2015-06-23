From: b.reynal@virtualopensystems.com (Baptiste Reynal)
Date: Tue, 23 Jun 2015 08:56:40 +0200
Subject: [PATCH] VFIO: platform: enable ARM64 build
In-Reply-To: <1434990361.3700.228.camel@redhat.com>
References: <1434359632-20278-1-git-send-email-eric.auger@linaro.org>
 <CAN9JPjHh_DPzB1PRhkyaXjKvq47SYb6a4M0M=fO78Mp+YYefrQ@mail.gmail.com>
 <55883038.9060405@linaro.org>
 <1434990361.3700.228.camel@redhat.com>
Message-ID: <CAN9JPjFNZrgiK5dVQcLAhvE1_ceJ=mc3qXfKy7Q3gmVOmjwY0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 6:26 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 2015-06-22 at 17:56 +0200, Eric Auger wrote:
>> Hi Baptiste,
>>
>> No unfortunately I don't have any HW to test this currently. I just
>> test-compiled this. Up to you to decide whether you prefer waiting for a
>> functional test for this. I sent that patch since I expect ARM64 to be
>> the main platform where the VFIO platform drivermight be used for
>> virtualization use case.


On my side, VFIO has been tested on ARM64 using Fastmodels without
problems, we can go ahead with the patch.

>
> FWIW, I've been occasionally removing the arch condition entirely to
> build test on x86 as well.  The Intel VT-d code certainly allows for
> devices described by ACPI, which I assume would fall under the platform
> category, but I don't know of any systems that do this, let alone any
> x86 platform devices that we'd actually want to expose to the user.
> Eventually we might want to consider decoupling this from an arch-based
> Kconfig option, but we could just as easily let the first non-ARM user
> think about that problem.  Thanks,
>
> Alex
>

Indeed, I'd rather wait for someone to show up with some use cases and
tests before removing this condition.

Regards,
Baptiste

>> On 06/22/2015 05:49 PM, Baptiste Reynal wrote:
>> > Acked-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
>> > Tested-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
>> >
>> > Out of curiosity, have you get VFIO running on ARM64 without any problems ?
>> >
>> > On Mon, Jun 15, 2015 at 11:13 AM, Eric Auger <eric.auger@linaro.org> wrote:
>> >> This patch enables building VFIO platform and derivatives on ARM64.
>> >>
>> >> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>> >> ---
>> >>  drivers/vfio/platform/Kconfig | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
>> >> index 1df7477..bb30128 100644
>> >> --- a/drivers/vfio/platform/Kconfig
>> >> +++ b/drivers/vfio/platform/Kconfig
>> >> @@ -1,6 +1,6 @@
>> >>  config VFIO_PLATFORM
>> >>         tristate "VFIO support for platform devices"
>> >> -       depends on VFIO && EVENTFD && ARM
>> >> +       depends on VFIO && EVENTFD && (ARM || ARM64)
>> >>         select VFIO_VIRQFD
>> >>         help
>> >>           Support for platform devices with VFIO. This is required to make
>> >> --
>> >> 1.9.1
>> >>
>>
>
>
>
