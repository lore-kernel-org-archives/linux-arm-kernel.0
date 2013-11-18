From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 18 Nov 2013 14:07:07 +0100
Subject: [PATCH v2] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <20131117083829.GK3538@lukather>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
 <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
 <CAOMqctTb0-B4y0DD6CWEi8Z7Bpd+pP-dWvvn5GiAkCeRD2v43g@mail.gmail.com>
 <52880460.9050700@elopez.com.ar> <20131117083829.GK3538@lukather>
Message-ID: <CAOMqctQc7K4OwOiCu1UuRpQLmU-Gh43HE_y2tYVnokk84ignJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2013 09:38, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Nov 16, 2013 at 08:48:48PM -0300, Emilio L?pez wrote:
>> Hi,
>>
>> El 16/11/13 20:37, Michal Suchanek escribi?:
>> >Unfortunately,
>> >
>> >a20 has two Ethernets so you can't alias both to ethernet0.
>> >
>> >This has to be done on a per-board basis.
>> >
>>
>> That was my first thought, and partly why I did it per-board on v1
>> (the other part being that some boards do not have a phy, so having
>> an ethernet0 alias felt "wrong"). But after some quick testing, it
>> appears that aliases are overridable, so we could just add ethernet0
>> = &gmac; on qualifying boards when the gmac support is ready.
>
> Or we will just add it as ethernet1. U-boot is able to put the
> mac-address in the DT for every ethernet* nodes for as much ethernet
> nodes as you need.

I guess that would be fine for CT and CB2 which can have only one
physical ethernet (unless there are pins for adding another PHY) but
if there is ever board with two ethernets you want only one of them to
 get the mac address from u-boot.

Thanks

Michal
