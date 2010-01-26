From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 26 Jan 2010 20:49:26 +0900
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <20100126105322.GG15759@rakim.wolfsonmicro.main>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<1b68c6791001252332l5ee275c9we39c98691ad7692c@mail.gmail.com>
	<20100126105322.GG15759@rakim.wolfsonmicro.main>
Message-ID: <1b68c6791001260349s7eed010br51c7c033271bc4d0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 7:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 26, 2010 at 04:32:45PM +0900, jassi brar wrote:
>> On Tue, Jan 26, 2010 at 2:51 PM, ?<jassisinghbrar@gmail.com> wrote:
>
> Please delete irrelevant context when replying to mails, it's much
> easier to find the actual new text in the message that way.
ok

>> > + ? ? ? ? ? ? ? ? ? ? ? /* NOTE: If the codec ouputs just one slot,
>> > + ? ? ? ? ? ? ? ? ? ? ? ?* it *seems* our AC97 controller reads the only
>> > + ? ? ? ? ? ? ? ? ? ? ? ?* valid slot(if either 3 or 4) for PCM-In.
>> > + ? ? ? ? ? ? ? ? ? ? ? ?* For such cases, we record Mono.
>> > + ? ? ? ? ? ? ? ? ? ? ? ?*/
>> > + ? ? ? ? ? ? ? ? ? ? ? .channels_min = 1,
>
>> ? I would like to remove this anomaly and set channels_min = 2
>
> Why?
This hypothesis was based on wrong observation that AC97 can record stereo-mic
if two slots are marked valid and one of them is 6th.
I decided to remove it after that observation turned out wrong(testing error).
Even though this seems logical, but I have not verified it so I wanted
to remove.

>> ?And remove the second DAI_LINK in machine driver.
>
> Again, why?
The wm9713 doesn't support mono capture and AC97 controller
doesn't support stereo MIC capture. So the second dai link
is improper.
