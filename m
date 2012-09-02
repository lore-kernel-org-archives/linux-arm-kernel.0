From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 02 Sep 2012 10:27:29 +0200
Subject: [PATCH v2 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <CACRpkdYsPadKr1i8m5cCAFUUvJYUnLmc3j8evKM_6rPU5oGzRg@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>	<1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>	<1345623750-10645-2-git-send-email-sebastian.hesselbarth@gmail.com>	<5035445B.6000500@wwwdotorg.org>	<CABJ1b_Tdr80DGqb-FRzwDbF3m7g6fBguk5GtRAfRUYx5Sqy_cA@mail.gmail.com>	<50366E44.4030606@wwwdotorg.org>	<50369305.6050304@gmail.com>	<50369FEE.8000003@wwwdotorg.org>	<5036B639.20608@gmail.com>	<5036F651.4020700@wwwdotorg.org>	<5038F50E.7030807@gmail.com>	<503AF8B4.1070206@wwwdotorg.org>
 <CACRpkdYsPadKr1i8m5cCAFUUvJYUnLmc3j8evKM_6rPU5oGzRg@mail.gmail.com>
Message-ID: <50431871.1030507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2012 09:30 AM, Linus Walleij wrote:
> On Mon, Aug 27, 2012 at 6:33 AM, Stephen Warren<swarren@wwwdotorg.org>  wrote:
>> The pinctrl subsystem does expect a list of functions, and for each
>> function, a list of the groups where it can be selected. I admit that
>> when I think about this, it's slightly backward, since HW typically has
>> a list of pins/groups, and for each, a certain set of functions can be
>> selected. Oh well...
>
> I agree that this is how we engineered it, would it create big hassles
> for you to fix up the driver so it's the other way around Sebastian?
>
> I understand that the driver is perfectly working as it is, but from
> a subsystem maintainer point of view it is annoying if one driver
> turns the concepts around and it gets hard to maintain.

Stephen, Linus, Jason,

there is a v3 of the patch under internal review right now.

I know Stephen will not like it, but I decided not to have the list of
functions passed statically from the SoC specific part but generate it
out of pingroups during probe().

As soon as I have confirmation that it still works on the other SoCs,
I will send the updated patches for public review.

Maybe Jason can also comment on what branch he wants to have it based
on, as we all agreed to get it through the Marvell tree.

Sebastian
