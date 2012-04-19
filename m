From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 19 Apr 2012 11:56:09 -0700
Subject: [PATCH 13/13] SPEAr: Call clk_prepare() before calling clk_enable
In-Reply-To: <CAOh2x=maawrRjHhE3oGXfMOvsUbCkp9gWA_Kq-S0Dh7r6co6VA@mail.gmail.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <0c2dc6d1f11ac1cc4965b8e902d19fb356f0324b.1334660432.git.viresh.kumar@st.com>
 <CAJOA=zOKeSf5XvAAFgs=CnmzEWHRgNRT1FscGE0q-NHnxt8yrg@mail.gmail.com>
 <CAOh2x=maawrRjHhE3oGXfMOvsUbCkp9gWA_Kq-S0Dh7r6co6VA@mail.gmail.com>
Message-ID: <CAJOA=zNL8Gc1HUuvZoOgzECjzUvXqTLxyjV2h1ubXaEOMYUzoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 6:36 PM, viresh kumar <viresh.linux@gmail.com> wrote:
>
> On Apr 19, 2012 2:47 AM, "Turquette, Mike" <mturquette@ti.com> wrote:
>>
>> On Tue, Apr 17, 2012 at 4:15 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
>> > With common clock framework, it is must to call clk_{un}prepare()
>> > before/after
>> > clk_{dis}enable. This patch fixes this for SPEAr timer.
>> >
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> > ---
>> > ?arch/arm/plat-spear/time.c | ? ?8 ++++----
>> > ?1 files changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
>> > index a3164d1..4f05d26 100644
>> > --- a/arch/arm/plat-spear/time.c
>> > +++ b/arch/arm/plat-spear/time.c
>> > @@ -218,10 +218,10 @@ void __init spear_setup_timer(resource_size_t
>> > base, int irq)
>> > ? ? ? ? ? ? ? ?goto err_iomap;
>> > ? ? ? ?}
>> >
>> > - ? ? ? ret = clk_enable(gpt_clk);
>> > + ? ? ? ret = clk_prepare_enable(gpt_clk);
>>
>> Where do you call clk_enable? ?Further down in the code somewhere?
>
> I called prepare_enable() here.
> Did i get your question correctly?

My mistake.  When I glanced over the code I saw "clk_prepare" and
somehow skipped the "_enable" part.

Regards,
Mike

>> Also does this change break git bisect for your platform? ?Maybe you
>> should move this change before patch 12/13 to prevent run-time
>> breakage?
>
> Correct.
>
> --
> Viresh
