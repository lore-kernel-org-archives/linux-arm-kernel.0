From: fkan@apm.com (Feng Kan)
Date: Tue, 27 May 2014 09:59:02 -0700
Subject: [PATCH 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <CACRpkdaVYXU9GN5OymuP3JRsQO3unkRGb5vZN3Jb2nWSnkh1SQ@mail.gmail.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-2-git-send-email-fkan@apm.com>
 <CAAVeFu+TOfjfvisinv3oJ9PobdV9HcNJhr+3VYneSJ54uGwiAg@mail.gmail.com>
 <CAL85gmDjVszNd3TB51BGa+78wEEZmJfBOLNKOpTEvMTGU2VdBA@mail.gmail.com>
 <CACRpkdaVYXU9GN5OymuP3JRsQO3unkRGb5vZN3Jb2nWSnkh1SQ@mail.gmail.com>
Message-ID: <CAL85gmCZD90UUZgC0-X4hui2L1V5TuH++o3fA20pRF_ZQEpDQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 1:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 21, 2014 at 1:54 AM, Feng Kan <fkan@apm.com> wrote:
>
>> I see each bank as separate gpio chip. It is a simple way to
>> abstract the banks since they can operate independently.
>
> I think they should also be separate devices, and separate nodes
> in the device tree.
>
>> It also
>> provided me a way to fix the sysfs gpio base number, regardless if
>> a particular bank node is pulled out.
>
> The GPIO sysfs is unpredictable for this and many other
> reasons and should not be relied upon.
>
>> This is also done in similar way
>> in some other gpio drivers such as the dwapb gpio driver.
>
> I think the dwapb has it's registers mingled while your banks
> seem to be separate chunks.

Thanks for the comments, I will fix these problems. Just some details
in terms of the register layout. I will break out the gpio to separate
device nodes as instructed, I will have to use the reg attribute to offset
bank registers. Please let me know if it is acceptable.

gfc_gpio_fl0              GFC42'h1701c00c
gfc_gpio_fl0_mux      GFC42'h1701c010
gfc_gpio_fl1              GFC42'h1701c018
gfc_gpio_fl1_mux      GFC42'h1701c01c
gfc_gpio_fl2              GFC42'h1701c024
gfc_gpio_fl2_mux      GFC42'h1701c028
gfc_gpio_fl0_od        GFC42'h1701c030
gfc_gpio_fl1_od        GFC42'h1701c034
gfc_gpio_fl2_od        GFC42'h1701c038



>
> Yours,
> Linus Walleij
