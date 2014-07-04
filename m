From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 4 Jul 2014 14:52:10 +0900
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <CACRpkdb5BNr=c90x1N3foppK8jJ2nRTsr72VmDmxqBdh_hCMAA@mail.gmail.com>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
 <20140630163931.GD32514@n2100.arm.linux.org.uk>
 <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
 <CAAVeFuK8YPFh3gHRt7_n00SBN6raGj2KxU_rY3GFrQq4dT3LTA@mail.gmail.com>
 <20140701111041.GL23300@sirena.org.uk>
 <CAAVeFuLc9GVMXQt=6oSkcHwH4ZpoOQkpj7uivUHZW+UkmEdDrw@mail.gmail.com>
 <CACRpkdb5BNr=c90x1N3foppK8jJ2nRTsr72VmDmxqBdh_hCMAA@mail.gmail.com>
Message-ID: <CAAVeFuJU3nGoVkA-Ag7rEf=WM524WD0S+60r05a_H+9+VDz4Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 7:07 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 1, 2014 at 2:27 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Tue, Jul 1, 2014 at 8:10 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Tue, Jul 01, 2014 at 09:59:01AM +0900, Alexandre Courbot wrote:
>
>>> I don't see security as a big deal - so long as normal, well written
>>> code gets the benefit of the access protection I think we're doing
>>> enough.  If something jumpst through hoops to bypass it then it's buggy
>>> but fundamentally we have to trust the kernel to at least some extent.
>>
>> The security consideration apart, making GPIOs obtained through gpiod
>> shareable seems to be a good way to solve the issue we are having
>> here.
>>
>> Linus, if you agree with the idea I can try to give it a shot sometime
>> this week.
>
> I'm game for this approach. I hope this can get Russell's original
> problem out of the way.

Great, I will give it a shot then. Could you let me know what you
think about my patch series that moves the different GPIO APIs into
their own files, so I know which base I should work on? IMHO if we are
to implement different behaviors for the integer and descriptor
interfaces, it makes all the more sense to have them in different
source files.
