From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 15 Apr 2015 09:34:48 +0300
Subject: AM335x OMAP2 common clock external fixed-clock registration
In-Reply-To: <20150414211734.GA28974@deathray>
References: <20150414211734.GA28974@deathray>
Message-ID: <552E0688.1020903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 12:17 AM, Michael Welling wrote:
> Greetings,
>
> I have developed an AM3354 based SoM and it uses an external SI5351 clock
> generator to drive the clock inputs for an external duart and I2S audio
> master clock. With the registration according to the documentation the
> reference clock is not being detected and hence the clock generator is
> not working as expect.
>
> After trying many different things, I started to look around the mailing
> lists to find information related to this issue.
>
> I came acrossed post that has the exact same issue:
> https://lkml.org/lkml/2013/2/18/468
>
> Seeing as the patch did not land upstream, I am wondering if there is
> a solution that I am not seeing.
>
> I am willing to provide a patch given appropriate guidance.

Hi Michael,

The info on the email you referenced is kind of obsolete, TI SoCs are 
calling of_clk_init() during boot now, and thus external clock nodes 
should be registered fine also. Maybe you can provide the actual DTS 
patch you are trying out so we can help better...? Are you seeing any 
boot time error / warning prints for your new clock?

-Tero
