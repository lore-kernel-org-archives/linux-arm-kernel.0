From: stefan@agner.ch (Stefan Agner)
Date: Thu, 16 Apr 2015 21:40:55 +0200
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
In-Reply-To: <1429208077.2563.14.camel@collins>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
 <f6f4f862c78fa626e7f94bde51eec5b1@agner.ch>
 <1429175421.2483.1.camel@collins>
 <CAL_JsqKdHQZL5Z6hKgquKihFykX0ZiCDQfeHOfOZWOh2NMg4Rw@mail.gmail.com>
 <CFEF8F54-7A3E-482C-B295-6A6BC5D837C8@codeaurora.org>
 <1429199145.2563.9.camel@collins>
 <F4D05489-ACF0-44BB-AEC7-7E8FB83FAE4C@codeaurora.org>
 <1429208077.2563.14.camel@collins>
Message-ID: <97473e9075df185ab3024db70c471f53@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-16 20:14, Paul Kocialkowski wrote:
> Le jeudi 16 avril 2015 ? 10:53 -0500, Kumar Gala a ?crit :
>> > On Apr 16, 2015, at 10:45 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
>> >
>> > Le jeudi 16 avril 2015 ? 10:23 -0500, Kumar Gala a ?crit :
>> >>> On Apr 16, 2015, at 9:36 AM, Rob Herring <robherring2@gmail.com> wrote:
>> >>>
>> >>> On Thu, Apr 16, 2015 at 4:10 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
>> >>>> Le jeudi 16 avril 2015 ? 09:56 +0200, Stefan Agner a ?crit :
>> >>>>> On 2015-03-28 18:39, Paul Kocialkowski wrote:
>> >>>>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> >>>>>
>> >>>>> I think this is a worthwhile standardization.
>> >>>>>
>> >>>>> Acked-by: Stefan Agner <stefan@agner.ch>
>> >>>>
>> >>>> Thanks! I should also add a commit message in v2 mentioning that this is
>> >>>> already used in open firmware and reported by lshw.
>> >>>
>> >>> With that,
>> >>>
>> >>> Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > [snip]
>> >
>> >> I feel like this is a little lite either in the doc or commit message.
>> >> Is the string completely arbitrary?  Is it meant to match labeling on
>> >> a board or case?  Is this meant to be used by the kernel at all?
>> >
>> > I guess it doesn't really matter what it is, as long as it's a string.
>> > The kernel does not suggest any use for it either, it's just made
>> > available to userspace through cpuinfo.
>> >
>> > Now if there is a particular use for this in user-space, it would have
>> > to match some standards. For instance, it Android, ro.serialno is
>> > usually a 16-bytes (plus one null byte) representation of a 64 bit
>> > number. For USB, I recall it is usually a 32 bytes string (including the
>> > null byte), but may be extended to more.
>> >
>> > What the string actually represents depends and some SOCs have serial
>> > number bytes (I know that omap and sunxi have some for instance, that
>> > are usually used) while other devices may take it from somewhere else.
>> > In any case, it doesn't really matter and is not up to the kernel anyway
>> > since it is just passed through from the bootloader.
>> >
>> > Thus, I don't think it's very relevant to mention it in either the
>> > documentation or the commit message.
>>
>> So you say ?board? in the patch, since it could be SoC specific, we
>> should probably clean up the wording a bit.
> 
> It really doesn't matter where the string comes from, what it contains
> or whether some SoCs have provisions to generate one.
> I think board is one the most common words that we can use to describe
> devices. "devices" is also fine, I could go with it if you prefer, but I
> don't really see what it changes.

There is already something related for SoC's in SoC bus called soc_id,
see
Documentation/ABI/testing/sysfs-devices-soc

So I would rather prefer that this is more reserved for device/board
serial number...

--
Stefan
