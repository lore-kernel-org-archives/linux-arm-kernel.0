From: dima@android.com (Dima Zavin)
Date: Tue, 22 Feb 2011 12:47:14 -0800
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
	<1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTi=0Pxg09x8DdVDVy9Ur7r1dgB+4LM3q0hM4_8Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 10:46 AM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Thu, 2011-02-17 at 16:51 -0800, Bryan Huntsman wrote:
>> On 02/17/2011 04:37 PM, Daniel Walker wrote:
>> > Can you put this in drivers/ this doesn't looks like it need to be here.
>>
>> Where would you suggest? ?The initial attempt to model SSBI as an I2C
>> bus didn't go anywhere. ?See http://lkml.org/lkml/2010/7/21/400. ?This
>> functionality is specific to MSM. ?Plus, we're trying to maintain
>> similarity to the Android MSM tree. ?That may not matter to people who
>> don't use MSM, but is matters to us. ?Given these considerations, the
>> current location seems as good a place as any.
>
> I don't know the driver well enough to be more detailed than suggesting
> drivers/ . In the thread you quoted Pavel (who I added to the CC line)
> suggested drivers/ssbi/ .

I'm not sure that knowing the driver would help. SSBI is a Qualcomm
proprietary protocol that will only ever have one ssbi "host" driver
in it. The slave is always the PMIC (maybe the audio codec too, but
that's normally speaking i2c even in qualcomm's case). The slave PMIC
drivers, however, will go under drivers/mfd for the core and the
peripheral drivers into the appropriate drivers/xxx/ dirs, just like
all the other pmic drivers. The audio codec would go into
sound/soc/codecs. Thus, adding drivers/ssbi/ to just house ssbi.c
doesn't really make sense to me.

What is the problem leaving it under arch/arm/mach-msm?

--Dima
