From: emil@limesaudio.com (Emil Lundmark)
Date: Fri, 7 Oct 2016 18:02:32 +0200
Subject: [PATCH 1/2] ARM: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <CAOMZO5CYST3fw1q11RidmSMepsUpaHg91T5gD_c6XA6vsAsJLQ@mail.gmail.com>
References: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
 <20161007141224.GA18011@lime>
 <CAOMZO5CYST3fw1q11RidmSMepsUpaHg91T5gD_c6XA6vsAsJLQ@mail.gmail.com>
Message-ID: <20161007160231.GA10773@workstation.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 12:34:42PM -0300, Fabio Estevam wrote:
> Hi Emil,
> 
> On Fri, Oct 7, 2016 at 11:12 AM, Emil Lundmark <emil@limesaudio.com> wrote:
> > I realize that the two patches in this series does not actually depend on
> > each other. This is my first contribution to Linux so I wonder if I should
> > resubmit these as two separate patches instead?
> >
> > For example, what if the second patch in the series is not needed? Do you
> > only accept the first patch then? Or what if I need to revise the second
> > patch? It seems unnecessary to include the first patch in that case.
> >
> > I also got the threading wrong, but thats another story.
> 
> It is better to resend these two patches and mark them as v2:
> [PATCH v2 1/2]
> [PATCH v2 2/2]
> 
> Then put below the --- line what has changed from the previous one. If
> nothing changed just put "None".
> 
> I am wondering if your patch series tries to fix the regression
> reported by Ken Lin or is it unrelated?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/460451.html

I was not aware of that issue before but it seems related. Only the first
patch in the series is relevant for solving the issue I was experiencing.
I can't tell if it also solves theirs, but it's probable.

The second part is really only nitpicking I discovered when debugging. Its
intention is to allow a precision of 1 Hz instead of (most likely) 24 Hz.
But when is that important for MHz clocks anyway?

-- 
Emil Lundmark
