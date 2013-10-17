From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 18 Oct 2013 03:53:31 +0400
Subject: [PATCH 1/3] ALSA: pxa: slightly refactor reset handling
In-Reply-To: <20131017233607.GW2443@sirena.org.uk>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
 <20131017233607.GW2443@sirena.org.uk>
Message-ID: <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Oct 18, 2013 at 3:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 17, 2013 at 02:01:35PM +0400, Dmitry Eremin-Solenikov wrote:
>> PXA25x also shows some problems when using interrupts during reset
>> handling. Thus do not use interrupts on all pxa kinds (to detect codec
>> ready state). Instead use a common mdelay-loop on all platforms to
>> detect codecs becoming ready.
>
> Applied all, thanks.  I'm somewhat surprised nobody noticed the reset
> issues on the pxa25x before - this stuff all got really heavily tested
> back in the day.

Maybe it was some coincidence/whatever. Maybe it is some hardware issue
of exact mask version. When I first started hacking around PXA, it was known
that tosa sometimes does not reset the AC97 codec for the first time.
However it looks like nobody bothered to debug that, because in most (~3/4)
cases reset went through. Now some kernel changes made kernel hang
looping in the interrupt, if the reset is not properly handled.

-- 
With best wishes
Dmitry
