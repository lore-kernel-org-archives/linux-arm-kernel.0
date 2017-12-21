From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 10:18:28 +0100
Subject: [PATCH V2 9/9] ARM: dts: stm32: add initial support of
 stm32mp157c eval board
In-Reply-To: <27a339f7-33a7-eb73-27fe-9927838729d6@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-10-git-send-email-ludovic.Barre@st.com>
 <CACRpkdZaEjdGB2k6HdPt1_E0jRXEimEUxT9NmMwMw7OiyeqGLA@mail.gmail.com>
 <27a339f7-33a7-eb73-27fe-9927838729d6@st.com>
Message-ID: <CACRpkdYE+u1o_KDDihX7=7RLNDkkFDOCFsQtBKBZW0i6123ZoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 10:19 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 12/20/2017 08:44 AM, Linus Walleij wrote:

>> gpio-line-names = "foo", "bar" ...;
>>
>> See for example
>> arch/arm/boot/dts/bcm2835-rpi-a.dts
>> arch/arm/boot/dts/ste-snowball.dts
(...)
>
> It looks like useful for pins used as gpio line. Are you saying that we also
> have to describe pins used as Alternate Function ?

No. The use of the names is up to the platform maintainer (you),
leaving a blank string for non-GPIO lines is just fine.

Some platforms add the name of the actual function used by the
line on the design, if it is not GPIO, sometimes something in
brachets like "[i2c0-SDA]" that says what it is used for and explains
why you can't use it for GPIO on this setup.

But just leaving it blank is just as good.

Yours,
Linus Walleij
