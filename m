From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 18:50:33 +0900
Subject: [PATCH 3/7] ARM: Samsung: Use the correct I2C2 interrupt
In-Reply-To: <006a01cb6084$348e9460$9dabbd20$%han@samsung.com>
References: <20100930044832.GA16905@july>
	<19620.20006.852861.438279@ipc1.ka-ro>
	<AANLkTim2saP2wGxF1U3v-p=PRvqOD+TFJwQ772kt1N-F@mail.gmail.com>
	<006a01cb6084$348e9460$9dabbd20$%han@samsung.com>
Message-ID: <AANLkTimMiqvbr2R81gdHPRhK_bAom=YC8quDnrD_4jBc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 6:45 PM, Jongsun Han <jongsun.han@samsung.com> wrote:
> On Thu, Sep 30, 2010 at 5:45 PM, Lothar Wa?mann <LW@karo-electronics.de>
>> wrote:
>> > Kyungmin Park writes:
>> >> From: Kyungmin Park <kyungmin.park@samsung.com>
>> >>
>> >> Use the correct I2C2 interrupt.
>> >>
>> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >> ---
>> >> ?arch/arm/plat-samsung/dev-i2c2.c | ? ?4 ++--
>> >> ?1 files changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-
>> samsung/dev-i2c2.c
>> >> index 07036de..ff4ba69 100644
>> >> --- a/arch/arm/plat-samsung/dev-i2c2.c
>> >> +++ b/arch/arm/plat-samsung/dev-i2c2.c
>> >> @@ -32,8 +32,8 @@ static struct resource s3c_i2c_resource[] = {
>> >> ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
>> >> ? ? ? },
>> >> ? ? ? [1] = {
>> >> - ? ? ? ? ? ? .start = IRQ_CAN0,
>> >> - ? ? ? ? ? ? .end ? = IRQ_CAN0,
>> >> + ? ? ? ? ? ? .start = IRQ_IIC2,
>> >> + ? ? ? ? ? ? .end ? = IRQ_IIC2,
>> >>
>> > Is there any reason for using 'IIC' here to refer to 'I2C'?
>>
>> Historical reason previous s3c24xx series use this name. I don't want
>> to break the s3c24xx series codes.
>> Instead I use the I2C after S5P series. I2C3, I2C4 and so on.
>>
>> If all person who works on s3c24xx and s5p series agree that use the
>> I2C. It can be used.
>>
>> Thank you,
>> Kyungmin Park
>
> Hi, Kyungmin
> IRQ_CAN0 is also used in arch/arm/mach-s5pc100/include/mach/irqs.h

Yes it's defined and will be used. but not I2C2
I already check it. at least my manual it's s5pc100 don't have I2C2.

Thank you,
Kyungmin Park

>
> Best Regards
> Jongsun Han
>
>
>
