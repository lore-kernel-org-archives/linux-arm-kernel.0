From: sunder.svit@gmail.com (Sundar)
Date: Fri, 3 Sep 2010 11:30:12 +0530
Subject: [PATCH 52/74] ST SPEAr13xx: Adding CPU hotplug support added for
	SMP platforms
In-Reply-To: <1980a48cb88189ce617fbfa2742d3259dd400b7b.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<1980a48cb88189ce617fbfa2742d3259dd400b7b.1283161023.git.viresh.kumar@st.com>
Message-ID: <AANLkTimzKd14U0k10Pjgb9UBWB2gixivvja8Qh_zMMLR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 30, 2010 at 4:09 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
>
> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---

> +       flush_cache_all();
> +       asm volatile(
> +       "       mcr     p15, 0, %1, c7, c5, 0\n"
> +       "       mcr     p15, 0, %1, c7, c10, 4\n"

Isnt this a Cortex-A9 platform? If yes, then this is not implemented
on the Cortex-A9 if I am right.
You should use a dsb() here.

> +               /*
> +                * here's the WFI
> +                */
> +               asm(".word      0xe320f003\n"
> +                   :

Also, why not a simple asm volatile("wfi" : : : "memory"); instead of
hard coded values.

Regards,
Sundar
