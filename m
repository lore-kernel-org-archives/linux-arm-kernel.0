From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 17 Oct 2016 16:24:31 -0700
Subject: [PATCH v2] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <CAOesGMijByw1FYt42toNF6pAEykks_agetQybhgMQj8nAc6xdg@mail.gmail.com>
References: <1476298306-9138-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMijByw1FYt42toNF6pAEykks_agetQybhgMQj8nAc6xdg@mail.gmail.com>
Message-ID: <207706e2-8fd4-748f-2ee7-3c372b447a7d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 16-10-17 02:58 PM, Olof Johansson wrote:
> Hi,
>
> On Wed, Oct 12, 2016 at 11:51 AM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Enable support for on board SPI EEPROM by turning on
>> CONFIG_EEPROM_AT25.  This needs to be on in order to
>> boot and test the kernel with a static rootfs image
>> that is not rebuilt everytime the kernel is rebuilt.
>
> If we did this for every kernel option we'd get a huge kernel.
>
> In general, we've said that static options for what's needed to boot
> to rootfs (i.e. storage and network drivers for nfsroot) are fine to
> enable statically.
>
> I doubt you need the EEPROM driver to boot to rootfs on your system,
> so please enable it as a module instead.
>
> Look into using config fragments in case you need to modify the
> options for local builds, it should be a convenient way to have a
> small delta to apply to fit your internal needs, instead of completely
> forking the config file.

Do you allow such config fragments to be upstreamed or do we need to 
maintain these in our tree?

>
>
> -Olof
>

Thanks,
  Scott
