From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 18:16:17 +0900
Subject: [PATCH 3/7] ARM: Samsung: Use the correct I2C2 interrupt
In-Reply-To: <19620.20006.852861.438279@ipc1.ka-ro>
References: <20100930044832.GA16905@july>
	<19620.20006.852861.438279@ipc1.ka-ro>
Message-ID: <AANLkTim2saP2wGxF1U3v-p=PRvqOD+TFJwQ772kt1N-F@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 5:45 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Kyungmin Park writes:
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Use the correct I2C2 interrupt.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/plat-samsung/dev-i2c2.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
>> index 07036de..ff4ba69 100644
>> --- a/arch/arm/plat-samsung/dev-i2c2.c
>> +++ b/arch/arm/plat-samsung/dev-i2c2.c
>> @@ -32,8 +32,8 @@ static struct resource s3c_i2c_resource[] = {
>> ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
>> ? ? ? },
>> ? ? ? [1] = {
>> - ? ? ? ? ? ? .start = IRQ_CAN0,
>> - ? ? ? ? ? ? .end ? = IRQ_CAN0,
>> + ? ? ? ? ? ? .start = IRQ_IIC2,
>> + ? ? ? ? ? ? .end ? = IRQ_IIC2,
>>
> Is there any reason for using 'IIC' here to refer to 'I2C'?

Historical reason previous s3c24xx series use this name. I don't want
to break the s3c24xx series codes.
Instead I use the I2C after S5P series. I2C3, I2C4 and so on.

If all person who works on s3c24xx and s5p series agree that use the
I2C. It can be used.

Thank you,
Kyungmin Park
>
>
> Lothar Wa?mann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
>
