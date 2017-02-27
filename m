From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 27 Feb 2017 11:48:50 +0800
Subject: [PATCH RFC] arm64/mm: handle memmap kernel option
In-Reply-To: <CAKv+Gu9j_4kSVAPrddsdcDiW+MWMTweHPe9bthf4=n4jLt2NZw@mail.gmail.com>
References: <1488005245-54811-1-git-send-email-xieyisheng1@huawei.com>
 <CAKv+Gu9j_4kSVAPrddsdcDiW+MWMTweHPe9bthf4=n4jLt2NZw@mail.gmail.com>
Message-ID: <ab8d4b0a-dfe5-629f-5ead-3c7e907509fa@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Thanks for comment.
On 2017/2/26 18:46, Ard Biesheuvel wrote:
> On 25 February 2017 at 06:47, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> When use device tree mode, user can reserve memory by changes the dts,
>> however, when boot with ACPI, user cannot reserve memory except by
>> changing the ACPI table in BIOS, which is not so convenient.
>>
>> To make user reserve memory for some specific use more convenient,
>> this patch implement the following memmap variants:
>>  - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
>>  - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;
>>
>> Reported-by: Bob Dong <dongbo4@huawei.com>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
> Could you explain which problem you are solving here? ACPI implies
> UEFI on arm64, and so these reservations could be made by a boot
> component instead, if it requires a fixed memory reservation. If this
> is a reservation for, e.g., OP-TEE, we should not rely on the command
> line to communicate this information.
> 
We just want to reserve some memory for a driver and I just not so familiar
with how to reserve memory with UEFI. So doubt about whether it is suitable
to reserve memory with cmdline like "memmap=xxx", which had appeared in x86
for a long time.

Thanks
Yisheng Xie
