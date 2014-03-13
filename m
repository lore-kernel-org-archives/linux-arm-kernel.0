From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Mar 2014 13:59:08 +0900
Subject: [PATCH] ARM: shmobile: Check r8a7791 MD21 at SMP boot
In-Reply-To: <20140313020231.GC16719@verge.net.au>
References: <20140226095916.15676.99394.sendpatchset@w520>
 <CAMuHMdXKdN+LrhhCFKgO4=2ez0qiyc8EhtBLPzrfxmBMLpGX7Q@mail.gmail.com>
 <CANqRtoQbx4LvaFxd_O6Em79QceSadVq93mJhyrDiD370VaXgWg@mail.gmail.com>
 <CAMuHMdU9CPsvV-MdO88QG3Xd0QQJxK0w9nH5ky6b+t7_rXsFGw@mail.gmail.com>
 <20140313020231.GC16719@verge.net.au>
Message-ID: <CANqRtoRCO+b3CGaOQW2FoetoOC0JCXmXK39Fgi_VinNGmbarJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Mar 13, 2014 at 11:02 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Feb 27, 2014 at 09:08:06AM +0100, Geert Uytterhoeven wrote:
>> Hi Magnus,
>>
>> On Thu, Feb 27, 2014 at 4:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> >>>  This is a reworked version of the APMU patch previously posted as
>> >>>  [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU
>> >>
>> >> Your previous version also affected r8a7790/Lager.
>> >> Isn't this check no longer needed there? According to the Lager manual,
>> >> MD21 also enables hardware debug mode, and is also controlled by
>> >> SW8-4. Of course the CPU may behave differently, as the CPU cores
>> >> are different.
>> >
>> > Yes, you are correct that the previous version of the patch also
>> > affected Lager. And that both r8a7790 and r8a7791 mention the MD21 bit
>> > together with JTAG debugging.
>> >
>> > I recently used the patch on Lager and I discovered that I apparently
>> > had been running with MD21 on my Lager since forever, and surprisingly
>> > it worked regardless. Since there is no documentation on r8a7790 or
>> > r8a7791 I simply decided to handle them separately and only enable
>> > where it is needed.
>>
>> You could have been lucky?
>>
>> On Koelsch, I only had failures after Real Cold Boot, i.e. on boot up in the
>> morning. And not always, so there could be a timing issue involved.
>>
>> > I've also been told that it is possible to allow SMP operation
>> > together with JTAG, apparently some magic with RST is needed. It seems
>> > that the power domains are treated differently depending on the MD21
>> > setting. Not sure if this applies to both r8a7790 and r8a7791, but if
>> > we end up with similar fixes we can consolidate. Until then I think
>> > dealing with them one by one makes sense.
>>
>> Furthermore, I haven't seen any SPI timeouts after I disabled MD21 (holding
>> wood, and rabbit legs ;-). So the SMP memory (in)coherency I saw there
>> could have been caused by a wobbly SMP setup.
>
> Hi Magnus,
>
> I am a little confused about the status of this patch?
> Would you like me to queue it up?

Yes, please!

/ magnus
