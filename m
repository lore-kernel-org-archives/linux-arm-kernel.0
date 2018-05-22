From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 23 May 2018 00:01:57 +0200
Subject: [PATCH 6/9] ARM: dts: wheat: Drop MTD partitioning from DT
In-Reply-To: <CAMuHMdXRnoyhNz=3v_=ZCV=FWX4TwKqx7MpH0g3c7GwtXKP1tg@mail.gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
 <20180522120257.13232-6-marek.vasut+renesas@gmail.com>
 <CAMuHMdXRnoyhNz=3v_=ZCV=FWX4TwKqx7MpH0g3c7GwtXKP1tg@mail.gmail.com>
Message-ID: <fc1cfd7e-db27-9277-dbed-cc2274c614a6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2018 04:43 PM, Geert Uytterhoeven wrote:
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
> I think the "@0" can be dropped, as it's optional?
> 4m?

My take on this is that the loader is actually at offset 0x0 of the MTD
device and we explicitly state that in the mtdparts to anchor the first
partition within the MTD device and all the other partitions are at
offset +(sum of the sizes of all partitions listed before the current
one) relative to that first partition.

Removing the @0 feels fragile at best and it seems to depend on the
current behavior of the code.

> (Gaining more knowledge during reviewing ;-)
> 
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
Best regards,
Marek Vasut
