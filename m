From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Jul 2011 19:40:32 +0900
Subject: [PATCH] mfd: convert devicetree to platform data on max8925
In-Reply-To: <20110710091729.GA23521@opensource.wolfsonmicro.com>
References: <1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
	<20110710072027.GE10912@ponder.secretlab.ca>
	<20110710091729.GA23521@opensource.wolfsonmicro.com>
Message-ID: <CACxGe6sEkToYu01wQpj6ey+--JMkDkK8s4U5aqwxoppSGRb1OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 6:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 10, 2011 at 04:20:27PM +0900, Grant Likely wrote:
>> On Fri, Jul 08, 2011 at 06:20:26PM +0800, Haojian Zhuang wrote:
>
>> > + ? if (pdata == NULL)
>> > + ? ? ? ? ? return NULL;
>> > + ? pdata->regulator[0] = kzalloc(sizeof(struct regulator_init_data)
>> > + ? ? ? ? ? ? ? ? ? * MAX8925_MAX_REGULATOR, GFP_KERNEL);
>
>> ditto.
>
>> Is it appropriate to allocated the entire table of regulators? ?From
>> the parse_regulator function above, it looks like only one of the
>> regulators will actually get registered (I've not dug deeply into what
>> the driver needs here though).
>
> If the code/binding doesn't allow the use of all the regulators on the
> device the code is probably wrong, it'd be very unusual to have hardware
> like that.

I was wondering about that.  I was just going by what I could
understand of the code.

g.
