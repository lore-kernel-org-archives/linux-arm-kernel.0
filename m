From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Jun 2015 09:16:02 +0200
Subject: [PATCH v2 6/6] ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33 and
 1024x600 lcd support
In-Reply-To: <20150616174114.GI11732@lukather>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
 <20150602081459.GO23777@lukather> <556D6955.8030708@redhat.com>
 <20150603094535.GI23777@lukather> <556EE104.3090803@redhat.com>
 <20150613135002.GP19653@lukather> <557C3BD3.6030105@redhat.com>
 <20150616174114.GI11732@lukather>
Message-ID: <55811EB2.4060302@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-06-15 19:41, Maxime Ripard wrote:
> Hi,
>
> On Sat, Jun 13, 2015 at 04:18:59PM +0200, Hans de Goede wrote:
>>> Pantelis, to sum things up, we have a case of a tablet that comes with
>>> the exact same board, but coming in two flavours with two differents
>>> screen resolutions. It looks like a great case for your DT quirks
>>> work, but we have no way of runtime detecting the difference between
>>> the two variants. What do you think about this? Should we go with
>>> using the DT quirks or is this simply out of scope?
>>>
>>> There's not so much example of similar cases in the kernel, and none
>>> of them use quirks so far (obviously) but they all boil down to either
>>> the solution you were suggesting in that patch or adding the alternate
>>> configuration as a comment.
>>>
>>> I don't think the latter would work for you, and I agree with that, so
>>> I guess that depending on what Pantelis says, either we go with a
>>> better solution using the quirks, or we end up using what you
>>> suggested (with a nitpick though, I'd prefer if you used the display
>>> standard instead of the resolution, which would make it xga I guess?)
>>
>> If we go with a separate dts file for each of the 800x480 and 1024x600
>> screens, I would greatly prefer to stick with the lcd1024x600 in the dts
>> filename instead of using something like xga, the fact that you say:
>> "I guess" that my answer to that is: I dunno I would need to look this
>> up in wikipedia or some such makes me think that using a qualifier like
>> xga is not going the help end users decide which dts file to pick, it
>> will just lead to them needing to go to wikipedia too. Also note that
>> the advertising of these tablets on ebay / aliexpress almost always
>> uses the resolution and not something like "xga".
>>
>> So all in all if we do not decide to use quirks for this I would like
>> to keep the filename as is.
>
> Yeah, except that the display standard is also encoding the refresh
> rate and color depth

Huh? No it does not, see e.g.:

https://en.wikipedia.org/wiki/Graphics_display_resolution

Note nothing about depth and refresh-rate there, and I've really never
heard anyone use things like xga to refer to colordepth and/or refreshrate

Regards,

Hans
