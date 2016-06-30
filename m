From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 30 Jun 2016 11:50:01 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm, nvram_file_name
 dt property
In-Reply-To: <87eg7f6odi.fsf@kamboji.qca.qualcomm.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <ea10ff70-26e6-e151-5cea-c54bd12a054c@redhat.com>
 <f8995599-115d-87e5-7928-c029b48584f1@broadcom.com>
 <6402170.5s0abZDqlD@wuerfel> <1467230078.2598.2.camel@plaes.org>
 <87eg7f6odi.fsf@kamboji.qca.qualcomm.com>
Message-ID: <e94f58fe-f709-94bd-21f6-144c4e038d17@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30-06-16 11:02, Kalle Valo wrote:
> Priit Laes <plaes@plaes.org> writes:
>
>>> What is the size of this nvram file? As it's board specific, I wonder
>>> if we can simply include it inside of the DT verbatim. I remember
>>> doing that (in the pre-dtb days, on real open firmware) for the
>>> "spidernet"
>>> ethernet driver.
>>
>> It contains a bit too much info:
>>
>> This is what CubieTruck requires:
>>
>> http://dl.cubieboard.org/public/Cubieboard/benn/firmware/ap6210/nvram_ap6210.txt
>
> In the nvram file I see lots of identifiers:
>
> manfid=0x2d0
> prodid=0x492
> vendid=0x14e4
> devid=0x4343
> boardtype=0x0598
> boardrev=0x1307
> boardnum=777
>
> Are any of these (or a combination of them) unique for each board type?
> What if one of these is provided through DT and then the driver could
> choose the nvram file based on the board id? Just another idea...

That would require updating a table in the driver every time a new
board comes out, I do not believe that that is a good solution.

Regards,

Hans
