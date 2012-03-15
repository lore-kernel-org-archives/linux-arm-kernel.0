From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 15 Mar 2012 17:10:45 +0900
Subject: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
In-Reply-To: <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com> <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
 <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
Message-ID: <002a01cd0283$1f61b200$5e251600$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Darius Augulis [mailto:augulis.darius at gmail.com]
> Sent: Thursday, March 15, 2012 4:42 PM
> To: Jingoo Han
> Cc: Thomas Abraham; linux-fbdev at vger.kernel.org; FlorianSchandinat at gmx.de; linux-arm-
> kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com; ben-
> linux at fluff.org; patches at linaro.org; Kyungmin Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark
> Brown; Peter Korsgaard; Maurus Cuelenaere
> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> Hi,
> 
> >
> > Yes, only single LCD resolution will be left.
> >
> >> I have mini6410 with both 4.3" and 7" LCDs and real6410 with 7" LCD. Now
> >> we have possibility to choose LCD size dynamically - leave it there.
> >> What you mean "default" 4.3" size LCD? The 7" size LCD is also provided
> >> by board sellers - I've bought it.
> >
> > OK, I see.
> > Both mini6410 and real6410 provide both 4.3" and 7" LCDs,
> > so you needs to select both LCDs.
> >
> > Um, usually, single LCD is provided on the single board.
> > Also, the daughter board with another kind LCD can be connected to the board.
> 
> There is single board - mini6410 (or real6410) and it's name doesn't
> depend on connected LCD size.
> We know, that this board is available with different sizes of LCD and
> currently we have in kernel support for both sizes.
> It might be so, that it's implemented not in perfect way, but it was
> accepted and at least it's working.


I don't think so.
You argues that the wrong code should not be removed because it was accepted and at least it's working.
It is just wrong usage, which can just work.
Moreover, your code will make the problem, when 2~5 windows of FIMD IP are used.
So, your code can be removed.


> If you want to rework s3c-fb platform data and driver framework, you
> should not drop any functionality created by other people.

Augulis, Thomas Abraham wants to rework s3c-fb platform data and driver framework, not me. :)
I am just reviewing the Thomas's patchset.

> 
> >
> > However, .win_mode is used not for LCD, but for windows of FIMD IP.
> > Actually, our current framework does not support to choose multi LCD,
> > so, I understand that you use .win_mode[1] as second LCD.
> > However, that's not accurate way to select multi LCD.
> >
> > Thomas, can you consider Augulis's opinion?
> > I think that the method to select multi LCDs is necessary.
> >
> > Ideal process is such as:
> > ?1. add the patch to support to select multi LCDs
> > ?2. apply above patch to make the mini6410 and real6410 to select multi LCDs.
> > ?3. apply Thomas's patchset to remove timing value from .win_mode variable.
> 
> Yes, this would be the right way to go.

However, skipping step 1 & 2 is also available, because your code is wrong.
As I'm mentioned above, your code will make the problem when 2~5 windows of FIMD IP are used.


> 
> regards,
> Darius A.
