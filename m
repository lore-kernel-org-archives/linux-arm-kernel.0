From: adrian.wenl@gmail.com (Lei Wen)
Date: Fri, 18 Jun 2010 16:44:43 +0800
Subject: [PATCH 01/25] pxa3xx_nand: condense the flash definition
In-Reply-To: <AANLkTinwlsrxvjHyEs1IAwaw-8GXYN2lVrUOtYp0C52n@mail.gmail.com>
References: <AANLkTil1FnPkGS7l6W0HWeXyOxXzWbZkvFWY4jJF_I_A@mail.gmail.com>
	<AANLkTinOsQ8AcH-As91CRqrEQVnXdsm_CmFQgyj7gI1_@mail.gmail.com>
	<AANLkTim9O5kuGzvQoB65fWDr3Bi9siiVBMCPx6heqZjd@mail.gmail.com>
	<AANLkTimGzVtuJuuxipim-f6UhdK287EjF41UlhdKCWRM@mail.gmail.com>
	<AANLkTindDgsvPK-ZZsyB2cdsrh0IyykBuhgStuwvyIdg@mail.gmail.com>
	<AANLkTinwlsrxvjHyEs1IAwaw-8GXYN2lVrUOtYp0C52n@mail.gmail.com>
Message-ID: <AANLkTikDXl0XwO_08T87l8jY-Lf_uNZDfOjrMfsnuCto@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 4:14 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 4:10 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
>> On Fri, Jun 18, 2010 at 4:00 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>>>> -struct pxa3xx_nand_timing {
>>>>>> - ? ? ? unsigned int ? ?tCH; ?/* Enable signal hold time */
>>>>>> - ? ? ? unsigned int ? ?tCS; ?/* Enable signal setup time */
>>>>>> - ? ? ? unsigned int ? ?tWH; ?/* ND_nWE high duration */
>>>>>> - ? ? ? unsigned int ? ?tWP; ?/* ND_nWE pulse time */
>>>>>> - ? ? ? unsigned int ? ?tRH; ?/* ND_nRE high duration */
>>>>>> - ? ? ? unsigned int ? ?tRP; ?/* ND_nRE pulse width */
>>>>>> - ? ? ? unsigned int ? ?tR; ? /* ND_nWE high to ND_nRE low for read */
>>>>>> - ? ? ? unsigned int ? ?tWHR; /* ND_nWE high to ND_nRE low for status read */
>>>>>> - ? ? ? unsigned int ? ?tAR; ?/* ND_ALE low to ND_nRE low delay */
>>>>>> -};
>>>>>> -
>>>>>> -struct pxa3xx_nand_cmdset {
>>>>>> - ? ? ? uint16_t ? ? ? ?read1;
>>>>>> - ? ? ? uint16_t ? ? ? ?read2;
>>>>>> - ? ? ? uint16_t ? ? ? ?program;
>>>>>> - ? ? ? uint16_t ? ? ? ?read_status;
>>>>>> - ? ? ? uint16_t ? ? ? ?read_id;
>>>>>> - ? ? ? uint16_t ? ? ? ?erase;
>>>>>> - ? ? ? uint16_t ? ? ? ?reset;
>>>>>> - ? ? ? uint16_t ? ? ? ?lock;
>>>>>> - ? ? ? uint16_t ? ? ? ?unlock;
>>>>>> - ? ? ? uint16_t ? ? ? ?lock_status;
>>>>>> -};
>>>>>> -
>>>>>> -struct pxa3xx_nand_flash {
>>>>>> - ? ? ? const struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
>>>>>> - ? ? ? const struct pxa3xx_nand_cmdset *cmdset;
>>>>>> -
>>>>>> - ? ? ? uint32_t page_per_block;/* Pages per block (PG_PER_BLK) */
>>>>>> - ? ? ? uint32_t page_size; ? ? /* Page size in bytes (PAGE_SZ) */
>>>>>> - ? ? ? uint32_t flash_width; ? /* Width of Flash memory (DWIDTH_M) */
>>>>>> - ? ? ? uint32_t dfc_width; ? ? /* Width of flash controller(DWIDTH_C) */
>>>>>> - ? ? ? uint32_t num_blocks; ? ?/* Number of physical blocks in Flash */
>>>>>> - ? ? ? uint32_t chip_id;
>>>>>> -};
>>>>>> -
>>>>>
>>>>> So does this prevent board code from defining their own timing and etc?
>>>>
>>>> No, platform could define its own timing. If there is definition for
>>>> the same chip,
>>>> driver would choose the one from platform definition first.
>>>>
>>>
>>> I'm seeing pxa3xx_nand_flash being referenced in pxa3xx_nand_platform_data
>>> below, though?
>>>
>>> struct pxa3xx_nand_platform_data {
>>>
>>> ? ? ?......
>>>
>>> ? ? ? ?const struct pxa3xx_nand_flash * ? ? ? ?flash;
>>> ? ? ? ?size_t ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?num_flash;
>>> };
>>>
>>
>> Yes, platform could define its own pxa3xx_nand_flash structure in its
>> own code, and pass the structure to let driver know.
>>
>
> I'm actually quite confused here. Did you ever try build a kernel with
> platform defined flash info?
>

I haven't tried to build one platform code with flash definition
yet... My fault...
I would correct this error in .h file.
