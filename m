From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 09 Jul 2013 18:43:16 +0100
Subject: [PATCHv3 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <51DC1858.8010008@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-2-git-send-email-alexandre.belloni@free-electrons.com>
 <51D53B72.6020309@metafoo.de> <51D7F044.9040205@kernel.org>
 <51DC1858.8010008@free-electrons.com>
Message-ID: <51DC4BB4.6060506@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, looks like I forgot to push the tree out.
Anyhow should be there shortly.

On 07/09/2013 03:04 PM, Alexandre Belloni wrote:
> Hi Jonathan,
> 
> I don't actually see it in iio.git on kernel.org, am I doing something
> wrong ?
> 
> On 06/07/2013 12:24, Jonathan Cameron wrote:
>> On 07/04/2013 10:08 AM, Lars-Peter Clausen wrote:
>>> On 06/24/2013 07:24 PM, Alexandre Belloni wrote:
>>>> The Nuvoton NAU7802 ADC is a 24-bit 2-channels I2C ADC, with adjustable
>>>> gain and sampling rates.
>>>>
>>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>>>
>> Applied to the togreg branch of iio.git (with a few little tweaks).
>>
>> There was some fuzz that required manual fixing because of another driver merge so
>> please check I didn't foul anything up with this or the other bits below.
>>
>> There were two trivial missing unlocks on error paths in the read_raw function that
>> I've fixed up (Coccinelle found these for me - if you can I would always advise
>> running sparse, coccicheck and ideally smatch before submitting patches).
>>
>> I fixed up the comments because if there is one thing I hate bothering
>> with it is delightful patches that just fix this stuff. Much better
>> to do it now given it took 20 secs ;)
>>
>>> One remark though. Multiline comments should be like
>>>
>>> /*
>>>  * foo
>>>  * bar
>>>  */
>>>
>>> not
>>>
>>> /* foo
>>>  * bar
>>>  */
>>>
>>> But not need to resend the patch just for this
>>>
>>> - Lars
>>>
> 
> 
