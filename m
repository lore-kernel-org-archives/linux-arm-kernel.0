From: carlo@caione.org (Carlo Caione)
Date: Wed, 24 Feb 2016 21:42:03 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <CAL9uMOG2gnGnxv9RmmKuHjc72xyyyEu3AW6pTyM2oA=aM171eQ@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <CAOQ7t2aqZj3STFsdTSQZMTK5U+8Oem8oFroxHKWkt=AeP+Zczg@mail.gmail.com>
 <CAD8Lp47LGUc3-MFpU+3iNjXJL0i4nLTY_49NUxFXeZ2SokDuaQ@mail.gmail.com>
 <3072897.5MMsyiojns@wuerfel>
 <CAL9uMOG2gnGnxv9RmmKuHjc72xyyyEu3AW6pTyM2oA=aM171eQ@mail.gmail.com>
Message-ID: <CAOQ7t2YXRwxvOpYBPYh7as94ZJSM3z44M2RR3vzG=mJY7ktZAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 2:25 PM, Carlo Caione <carlo@endlessm.com> wrote:

>> Maybe the best way is to make it compatible with both syscon and
>> simple-bus and put the other nodes underneath. That is still rather
>> ugly, but at least it works and can be extended.
>
> This is a good idea actually. I'll prepare a patch.
> Thank you for having spent time on this.

Apparently I talked too soon. The problem is the pinctrl driver where
one of the bank (ao-bank) is mapped into the aobus not cbus
http://lxr.free-electrons.com/source/arch/arm/boot/dts/meson8b.dtsi#L169
If you don't have a better idea probably I should try to decouple the
two banks so that we have two different pinctrl devices for each bus
(aobus and cbus).

Cheers,

-- 
Carlo Caione
