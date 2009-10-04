From: linuxzsc@gmail.com (Richard Zhao)
Date: Sun, 4 Oct 2009 20:22:17 +0800
Subject: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
In-Reply-To: <20091002141106.GG3179@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<20091001083831.GD27039@pengutronix.de>
	<4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com>
	<20091001095239.GE27039@pengutronix.de>
	<4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
	<20091001163753.GA20103@pengutronix.de>
	<4e090d470910011757g261c693ehdca40ce43ebee2ec@mail.gmail.com>
	<20091002072643.GH27039@pengutronix.de>
	<4e090d470910020117w620fda4cta7b26b912d01bc24@mail.gmail.com>
	<20091002141106.GG3179@pengutronix.de>
Message-ID: <4e090d470910040522u7139d790o6dfcb9f71b9e57eb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 2, 2009 at 10:11 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Fri, Oct 02, 2009 at 04:17:09PM +0800, Richard Zhao wrote:
>> On Fri, Oct 2, 2009 at 3:26 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Fri, Oct 02, 2009 at 08:57:04AM +0800, Richard Zhao wrote:
>> >> On Fri, Oct 2, 2009 at 12:37 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> >> >> > Ah, so 'make the driver work on i.MX51' is a good statement which should
>> >> >> > be part of the commit message.
>> >> >> Well, maybe I can mention it.
>> >> >> But I think the good point is to present what you modified, not the side effect.
>> >> >
>> >> > It is not the side effect but the intention :) As no code is changed without a
>> >> > need, the reason really should be in the patch description.
>> >> No, it's not intention. I'm just trying to make the controller work in
>> >> a right way. Without this patch, maybe some other fast cpus have
>> >> problem too. I just tested mx31 and mx51. I will add "Without this
>> >> patch, i2c on some fast SoCs (for example imx51) will not work". Is it
>> >> ok for you?
>> >
>> > Please remember that we do not have i.MX51 support in mainline, so this
>> > is irrelevant atm.
>> So I don't need to meantion mx51? "Without this patch, i2c on some
>> fast SoCs will not work" is all right?
>
> Sounds good to me!
>
>> > At the moment we have a driver which is not multi master capable.
>> > Looking at the datasheet the change you do seems not enough to change
>> > this. So we should take a patch which changes something from which you
>> > think it might be needed? And you don't even have the details at hand?
>> >
>> > No.
>> Ok, It seems I have no reason to keep the busy wait before START.
>> Wolfram, do you agree to remove the busy wait?
>
> If somebody really needs multi-master and is able to test it, then it can be
> reimplemented (but as said, this needs a lot more changes). Have to have a
> closer look though, if it may detect a stalled bus.
>
>> I saw you submmited the original driver.
>
> I helped in getting it accepted, but the commit is mainly from Darius.
>
> Regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkrGCfoACgkQD27XaX1/VRtdtQCfQY/HExUvAyQbilCV+F83UZZ4
> /ZQAnicn78e46mlqE3Z/9xXFMW8B2QCA
> =qYV9
> -----END PGP SIGNATURE-----
>
>

Let me sumerize the comments:
1. Sascha, Wolfram: tell why add IBB check in commit message. Add
something like "Without this patch, i2c on some fast SoCs will not
work". Agree
2. Sascha: Remove IBB check before START.  Agree.
3. Andrew: Optimize the busy wait loop. Agree.

Thanks
Richard
