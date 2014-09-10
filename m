From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 10 Sep 2014 09:13:27 +0200
Subject: [GIT PULL 1/2] SOCFPGA updates for 3.18
In-Reply-To: <20140909210232.GA539@amd>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd> <4134101.OOENTRabu1@wuerfel>
 <20140909210232.GA539@amd>
Message-ID: <CAPDyKFr35646zQUDUnv9LYy9jtY7r343hev9FrhxOfjVMb6MJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 September 2014 23:02, Pavel Machek <pavel@denx.de> wrote:
> On Tue 2014-09-09 17:02:34, Arnd Bergmann wrote:
>> On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
>> > > Jaehoon Chung (1):
>> > >       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
>> > >
>> >
>> > This patch is a bad idea. It removes support for two mmc cards on a
>> > single controller -- configuration hardware supports and configuration
>> > that allows using u-SD card on mcvevk board.
>> >
>>
>> Your objection comes too late, and to the wrong patch, since the
>> driver and all other users have already been changed. We had a long
>> discussion about this when the issue first came up, and we could
>> not find any example of dw-mmc actually being used in a scenario
>> with one controller that has multiple devices attached.
>
> Well, this is not first time I raised this. 3.17 is not yet out, so we
> still have chance to fix regressions without major fuss.
>
>> Apparently every user out there instead uses multiple controller
>> instances instead. Are you sure that the socfpga implementation
>> is an exception from this?
>
> Marek Vasut has the hardware. His board apprently has uSD and eMMC,
> and I believe it has just one controller. I'll try to get details.
>

Just wanted to highlight some of the reasons to why the earlier
discussion we have had, came to the conclusion to remove the slot
node.

1) The mmc core don't support multiple cards attached to the same
host, it never has. Also, I am not aware of any requests that
suggested us to add it. Due to obvious reasons from performance
perspective it's simply a really bad idea, that's likely also why
there haven't been any requests for it.

2) On the host level, the support for handle multiple slots in DT for
dw-mmc has been broken. While dw-mmc parsed the DT nodes for slots, it
screwed up configurations. Thus the support for slots have never
worked as expected from DT point of view.

Kind regards
Uffe
