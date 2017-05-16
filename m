From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 16 May 2017 10:15:29 +0200
Subject: [PATCH] arm64: check return value of of_flat_dt_get_machine_name
In-Reply-To: <fe4bcf5f-c8fb-6e42-6084-0d8583ccaa99@huawei.com>
References: <1494920176-13986-1-git-send-email-wangkefeng.wang@huawei.com>
 <CAMuHMdUpPDSkbMU2+TL5Z=ZXx8=K=V+75=pBPg_s-E9cww42GQ@mail.gmail.com>
 <fe4bcf5f-c8fb-6e42-6084-0d8583ccaa99@huawei.com>
Message-ID: <CAMuHMdXHfodx5GOzwazNm0uNGQQyM_kQKe6khp6UZVXz-dg6sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On Tue, May 16, 2017 at 10:11 AM, Kefeng Wang
<wangkefeng.wang@huawei.com> wrote:
> On 2017/5/16 15:54, Geert Uytterhoeven wrote:
>> On Tue, May 16, 2017 at 9:36 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>> It's useless to print machine name and setup arch-specific system
>>> identifiers if of_flat_dt_get_machine_name() return NULL, especially
>>> when ACPI-based boot.
>>
>> Is there an ACPI-equivalent of the machine name?
>> If yes, it would be useful to use that instead.
>
> We will get system identification string(machine name) from SMBIOS, see drivers/firmware/dmi_scan.c
> and arch/arm64/kernel/efi.c.
> arm64_dmi_init
> --dmi_scan_machine
>   --dmi_present/dmi_smbios3_present
>     --pr_info("DMI: %s\n", dmi_ids_string);
> --dmi_set_dump_stack_arch_desc

OK, and you have dump_stack_set_arch_desc() there.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
