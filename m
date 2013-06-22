From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 22 Jun 2013 15:20:25 +0200
Subject: [PATCHv2 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <51C5A1AF.3070404@free-electrons.com>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-2-git-send-email-alexandre.belloni@free-electrons.com>
 <51C590B5.2060308@kernel.org> <51C5923D.6030609@metafoo.de>
 <51C5A1AF.3070404@free-electrons.com>
Message-ID: <51C5A499.5050509@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2013 03:07 PM, Alexandre Belloni wrote:
> On 22/06/2013 14:02, Lars-Peter Clausen wrote:
>> On 06/22/2013 01:55 PM, Jonathan Cameron wrote:
>>> On 06/20/2013 07:57 PM, Alexandre Belloni wrote:
>>>> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
>>>> gain and sampling rates.
>>>>
>>> Sorry, somewhat low on time today so only a quick review.
>>>
>>> 1) Missing userspace ABI documentation.  Also, perhaps min_conversions is
>>>    a little vague?  Not that I have a better idea!
>> I really don't like the name min_conversions either. Isn't this effectively
>> a decimation filter?
> 
> Yeah, it could be seen like that but it is only relevant and only
> happens when switching between channels. I'm open to any ideas.
> 

I see. Is there anything about this in the datasheet on how many conversions
you usually need? Is this really something you need to change at runtime or
does moving this to platform data work?

- Lars
