From: airlied@gmail.com (Dave Airlie)
Date: Tue, 22 May 2012 11:02:37 +0100
Subject: [PATCH 2/2] pcm038 lcdc support
In-Reply-To: <20120518151316.GU30400@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <1337344032-25431-3-git-send-email-s.hauer@pengutronix.de>
 <1337349834.29229.15.camel@atropine>
 <20120518151316.GU30400@pengutronix.de>
Message-ID: <CAPM=9twNorVNJ4Jxd-hiW8jjMzqxzgyrjgwH=raFWuen5Na1ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 4:13 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, May 18, 2012 at 10:03:54AM -0400, Adam Jackson wrote:
>> On Fri, 2012-05-18 at 14:27 +0200, Sascha Hauer wrote:
>>
>> > + ? ? ? ? ? ? ? ? ? edid = [00 ff ff ff ff ff ff 00 4c 2d 6c 03 36 32 49 4b
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 0f 13 01 03 80 37 22 a0 2a fe 21 a8 53 37 ae 24
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 11 50 54
>> > +
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? /* est timings */
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00 00
>> > +
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? /* std timings */
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00
>> > +
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? /* detailed timings */
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 05 0D 20 A0 30 58 1C 20 28 20 14 00 26 57 21 00 00 1E
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00 00 fd 00 32 4b 1b 51 11 00 0a 20 20 20 20 20 20
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00 00 fc 00 53 79 6e 63 4d 61 73 74 65 72 0a 20 20
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 00 00 ff 00 48 39 58 53 34 30 30 34 34 32 0a 20 20
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? 00 20];
>>
>> This EDID block claims to be a Samsung SyncMaster, which isn't really
>> the right thing to do. ?The question is what to call it instead. ?Red
>> Hat has a PNP ID we can use for virtual EDID blocks like this if we
>> want, I'd want to set up a little database to keep track of them but
>> that's pretty trivial.
>
> Sorry, should have mentioned this in the commit log. This in fact is a
> hacked version of my office monitor. This patch is more meant as a usage
> example and not for upstream. I don't know yet if it's even acceptable
> to put edid data into the devicetree. I saw some discussion about it,
> but also about some generic display description, which I would prefer.
>
> BTW is there a more convenient tool than a hex editor around to generate
> edid data? I only found some windows tools

Some basic stuff in Documentation/EDID/ but yeah don't know of
anything graphical for Linux.

Dave.
