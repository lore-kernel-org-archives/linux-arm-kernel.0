From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Sun, 6 Mar 2011 13:21:19 +0530
Subject: hard coded value for idcode field in struct cpu_table
In-Reply-To: <AANLkTi=1zJoGwOXCbAaCn=+wRuAjgBsOUvKhOPqH0SaF@mail.gmail.com>
References: <AANLkTinYBcaOcuOMQBy+gN8h2i+fEOR9zT0c3DZQdP57@mail.gmail.com>
	<AANLkTi=1zJoGwOXCbAaCn=+wRuAjgBsOUvKhOPqH0SaF@mail.gmail.com>
Message-ID: <AANLkTi==5uRAvWfAen0=eNNcBJy-AoBm1M_iotdE69oa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/5 S?awomir Cygan <slawomir.cygan@gmail.com>:
> On Thu, Mar 3, 2011 at 2:49 PM, Madhavi Manchala
> <madhavi.linux@gmail.com> wrote:
>> Dear All,
>>
>> I do not understand the value of idcode field in the struct cpu_table
>> i.e. the value is hard coded. I did not find that value in the user
>> manuals also. The code is available at
>> linux/arch/arm/plat-s3c24xx/cpu.c file. Currently, I am implementing
>> code for Samsung S3C2510A processor which is not available in the
>> current sources. Where can I find the idcode value for Samsung
>> S3C2510A processor?
>>
>> Any ideas will be appreciated.
>>
>> Thanks and ?Regards,
>> Madhavi M.
>>
> Hi,
> This field is defined for example in this datasheed:
>
> http://www.alldatasheet.com/datasheet-pdf/pdf/84872/SAMSUNG/S3C2410A.html
>
> PDF page 282:
>
> GENERAL STATUS REGISTER (GSTATUSn)
> Register Address R/W Description Reset Value
> GSTATUS0 0x560000AC R External pin status Undefined
>
>>>>>> ? GSTATUS1 0x560000B0 R Chip ID 0x32410000 <<<
>
> GSTATUS2 0x560000B4 R/W Reset status 0x1
> GSTATUS3 0x560000B8 R/W Infrom register 0x0
> GSTATUS4 0x560000BC R/W Infrom register 0x0
>
> This is "GSTATUS1" register initial value
>
>
> I don't think that S3c25 are so similar to S3c25, so they provide
> exactly the same method of chip identification.

Thank you very much Slawomir Cygan for the information. However, I did
not find any CHIP ID in the S3C2510A documentation, as you said. There
are IDs which are PCI vendor ID and device ID. I guess, this is
different from that chip ID as in case S3C2410A.

Thanks and Regards,
Madhavi M.

>
> --
> Pozdrawiam,
> S?awomir Cygan
>
