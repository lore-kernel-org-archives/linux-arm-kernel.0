From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 17:25:07 -0700
Subject: [PATCH v2 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <CAN1soZyc8Kox__yOER82Oe5OtaLJWYAoMzgWGhEonTfdf11MqQ@mail.gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-6-git-send-email-haojian.zhuang@gmail.com>
 <5085CC3F.30708@wwwdotorg.org>
 <CAN1soZy8xXGs8zEiZV0kV0dGVdXfZ9ogx83sFgPG76d0i8yH4A@mail.gmail.com>
 <5091A5AA.7000207@wwwdotorg.org>
 <CAN1soZyc8Kox__yOER82Oe5OtaLJWYAoMzgWGhEonTfdf11MqQ@mail.gmail.com>
Message-ID: <20121101002506.GI15766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121031 15:53]:
> On Wed, Oct 31, 2012 at 11:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >
> > But that tends to imply that adding support for generic pinconf into the
> > pinctrl-simple driver isnt' actually going to be useful for anyone. If
> > pinctrl-single only supports some part of your HW, how can you use it?
> > Or, do you intend to somehow make pinctrl-single support both the common
> > generic pinconf stuff, and somehow be extensible to support any
> > SoC-specific pin config fields?
> 
> I'm intend to make pinctrl-single to support both the common generic pinconf
> stuff and any SoC-specific pinconf. I'll try to handle it. But they
> won't be included
> in V3.

The easiest way to support generic pinconf in pinctrl-single.c
is to set up a separate driver instance for the register ranges
that need it. Otherwise things can get messy.

Regards,

Tony
