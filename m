From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 23 Jul 2010 02:38:01 +0300
Subject: [PATCH v2 01/20] sdio: add TI + wl1271 ids
In-Reply-To: <1279735134.3035.9.camel@localhost.localdomain>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-2-git-send-email-ohad@wizery.com>
	<1279735134.3035.9.camel@localhost.localdomain>
Message-ID: <AANLkTilNefqQ08SgI9i_ZzjNTAU2ggd813DU0Hh22JlX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel,

On Wed, Jul 21, 2010 at 8:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Add SDIO IDs for TI and for TI's wl1271 wlan device.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> ?include/linux/mmc/sdio_ids.h | ? ?3 +++
>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
>> index 33b2ea0..0d313c6 100644
>> --- a/include/linux/mmc/sdio_ids.h
>> +++ b/include/linux/mmc/sdio_ids.h
>> @@ -43,4 +43,7 @@
>> ?#define SDIO_DEVICE_ID_SIANO_NOVA_A0 ? ? ? ? 0x1100
>> ?#define SDIO_DEVICE_ID_SIANO_STELLAR ? ? ? ? ? ? ? ? 0x5347
>>
>> +#define SDIO_VENDOR_ID_TI ? ? ? ? ? ? ? ? ? ?0x0097
>> +#define SDIO_DEVICE_ID_TI_WL1271 ? ? ? ? ? ? 0x4076
>> +
>
> are we still doing this non-sense for no real reason.  What is so wrong
> with keeping the IDs inside the driver code?

Either way we can't go so wrong here (having global VENDOR_IDs can
potentially prevent redefinitions of the same ID in different drivers,
but that's probably not that big of an
issue too).

But if we prefer people to stop adding IDs to this global pool, let's
at least make it clear. We can probably seal it with some "please
don't add new IDs if you don't have to" footnote (care to send such
patch ? :)

Thanks,
Ohad.


> Personally I don't even see a point for these ID defines at all. Just
> use the bare numbers in SDIO_DEVICE and put a comment above what kind of
> device this is.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
