From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 22 May 2018 23:55:27 +0200
Subject: [PATCH 2/9] ARM: dts: lager: Drop MTD partitioning from DT
In-Reply-To: <CAMuHMdV1TFH_QwTv4fsOGnUOCNftC9369_1AQmZDK+NBLDmw-Q@mail.gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
 <20180522120257.13232-2-marek.vasut+renesas@gmail.com>
 <CAMuHMdV1TFH_QwTv4fsOGnUOCNftC9369_1AQmZDK+NBLDmw-Q@mail.gmail.com>
Message-ID: <7f72e09a-3c02-7985-2c42-14e4034ff77e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2018 04:32 PM, Geert Uytterhoeven wrote:
> On Tue, May 22, 2018 at 2:02 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Drop the MTD partitioning from DT, since it does not describe HW
>> and to give way to a more flexible kernel command line partition
>> passing.
>>
>> To retain the original partitioning, assure you have enabled
>> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
>> following to your kernel command line:
>>
>>   mtdparts=spi0.0:256k at 0(loader),4096k(user),-(flash)
> 
> I guess s/4096k/4m/ works, too?

Yes, but all the other boards use nnn k, so let's stick with k . I don't
want one value to stick out like a sore thumb.

>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
Best regards,
Marek Vasut
