From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 6 Jan 2018 13:55:52 +0000
Subject: [PATCH 3/3] arm: KVM: Invalidate BTB on guest exit
In-Reply-To: <CAKv+Gu8JjwtoWUiY9zyhukarAfXB-LQHb10gb7tSE0iJ308b7w@mail.gmail.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
 <20180106120907.26701-4-marc.zyngier@arm.com>
 <CAKv+Gu8JjwtoWUiY9zyhukarAfXB-LQHb10gb7tSE0iJ308b7w@mail.gmail.com>
Message-ID: <20180106135552.568bc726@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 6 Jan 2018 13:35:46 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 6 January 2018 at 12:09, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > In order to avoid aliasing attacks against the branch predictor,
> > let's invalidate the BTB on guest exit. This is made complicated
> > by the fact that we cannot take a branch before invalidating the
> > BTB.
> >  
> 
> You can't even take an unconditional branch?

Yup.  We certainly have that restriction on arm64, and I assume it is
the same on 32bit.

	M.
-- 
Without deviation from the norm, progress is not possible.
