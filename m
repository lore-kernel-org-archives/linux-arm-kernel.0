From: eballetbo@gmail.com (=?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?=)
Date: Sun, 14 Nov 2010 19:11:46 +0100
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
In-Reply-To: <14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
Message-ID: <AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/14 Felipe Balbi <me@felipebalbi.com>:
> Hi,
>
> On Sun, 14 Nov 2010 11:34:12 +0000, Marc Zyngier <maz@misterjones.org>
> wrote:
>> @@ -272,8 +273,8 @@ static struct regulator_init_data igep2_vmmc1 = {
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | REGULATOR_CHANGE_MODE
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | REGULATOR_CHANGE_STATUS,
>> ? ? ? },
>> - ? ? .num_consumer_supplies ?= 1,
>> - ? ? .consumer_supplies ? ? ?= &igep2_vmmc1_supply,
>> + ? ? .num_consumer_supplies ?= 2,
>
> use ARRAY_SIZE(igep2_vmmc1_supplies),
>
> --
> balbi
>

Why we need to define an unexistent regulator in board file ? This
should not be done enabling the CONFIG_DUMMY_REGULATOR in your kernel
configuration  ?

Cheers,
   Enric
