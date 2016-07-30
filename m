From: hramrach@gmail.com (Michal Suchanek)
Date: Sat, 30 Jul 2016 19:32:51 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <20160729202247.GJ6215@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
 <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
 <20160725073204.GD7419@lukather>
 <CAOMqctQybJoOfUHGtpmpB_koQ=iY+GpQ_BOL2o0QBbwC_HXC0g@mail.gmail.com>
 <20160729202247.GJ6215@lukather>
Message-ID: <CAOMqctQkaQnEt6U3dd_kzi8GtfS_G3=hue3sz_TomMATn8o3iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2016 at 22:22, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Jul 25, 2016 at 10:03:14AM +0200, Michal Suchanek wrote:
>> Hello,
>>
>> On 25 July 2016 at 09:32, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Fri, Jun 17, 2016 at 12:34:44PM +0200, Michal Suchanek wrote:
>> >> Hello,
>> >>
>> >> On 13 June 2016 at 21:57, Maxime Ripard
>> >> <maxime.ripard@free-electrons.com> wrote:
>> >> > On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
>> >> >> Hello,
>> >> >>
>> >> >> This is update of the sunxi spi patches that should give full-featured SPI
>> >> >> driver.
>> >> >>
>> >> >> First three patches fix issues with the current driver and can be of use for
>> >> >> stable kernels so adding cc for those.
>> >> >>
>> >> >> I merged the sun4i and sun6i driver because there several issues that need to
>> >> >> be fixed in both separately and they are even out of sync wrt some fixes.
>> >> >> I guess some of the merge patches can be squashed.
>> >> >>
>> >> >> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
>> >> >> tell if that side was broken by this patchset - especially the last patch that
>> >> >> adds DMA was afaik never tested on sun6i.
>> >> >
>> >> >
>> >> > For the record, I'm still very much opposed to such a merge.
>> >>
>> >> What is the reason against the merge? I did not find the original
>> >> discussion.
>> >
>> > I really prefer some code that is concise and clear but a little
>> > duplicated over some code that shares every possible lines of code but
>> > is a giant mess impossible to understand.
>>
>> Yes, it's been tried. In the case of this driver there is more duplication
>> than differences. Also bitrot due to different variants receiving different
>> updates and fixes crept in already.
>>
>> Adding the remap layer certainly does not make the driver easier to
>> understand but it's not becoming giant mess either.
>
> Well, when you say that you're not quite fond of using your structure
> all over the place because "it makes your eyes bleed", I wouldn't call
> that a good sales pitch.

That's why put dereferencing it inside the read function. It reduces the noise
throughout the code and make it easier to add checks or change the remap
implementation.

>
> But again, reg_field seems like a good solution for that.

I will look at reg_field.

I saw some drivers using remap layers that are way more heavyweight than
looking up an integer in a table so I wanted to avoid that.

Thanks

Michal
