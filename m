From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 4 Sep 2012 18:53:24 +1000
Subject: [PATCH 4/4 v3] ARM: ks8695: convert to generic time and
 clocksource
In-Reply-To: <CACRpkdZ36r=mnKjYdqxd-aya2zO7UpLFea95hJxb58Z=YVifxQ@mail.gmail.com>
References: <1346700644-19352-1-git-send-email-linus.walleij@linaro.org>
 <504587C3.9040201@snapgear.com>
 <CACRpkdZ36r=mnKjYdqxd-aya2zO7UpLFea95hJxb58Z=YVifxQ@mail.gmail.com>
Message-ID: <5045C184.3080307@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2012 04:44 PM, Linus Walleij wrote:
> On Tue, Sep 4, 2012 at 6:46 AM, Greg Ungerer <gerg@snapgear.com> wrote:
>
>> Despite what the old code had, reading the T0TC (or the T0PD) does not
>> return the current count. It just returns what you set it too.
>
> Aha!
>
>> As far
>> as I can tell there is no programmer access to the clocks internal
>> counter on the KS8695. The data sheet doesn't seem to indicate any way to
>> access it.
>
> Hm, yeah the datasheet doesn't quite tell what is read back from
> that register, strange about the old code though, it's coded as if
> it could be read back :-/

Yeah, and I thought it could do that until I checked it on hardware.
It really does just read back what you wrote on all those registers.

Then looking more closely at the datasheet it says those registers are
read/write - but not that it reads back anything different to what you
wrote.

Regards
Greg



>> If I disable the clocksource_mmio_init section of code above then I get
>> working time again. I suspect that is as good as we can get on the
>> K8695.
>
> OK let me provide a patch that just does clocksource then.
> Let's just fall back to jiffies.
>
> Yours,
> Linus Walleij
>
>
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
