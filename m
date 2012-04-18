From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 13:24:14 +0200
Subject: [PATCH V4 3/5] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <4F8D2A88.6060309@st.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <f9cc539f87a9c73546fe6671d55d86838886adce.1334548272.git.viresh.kumar@st.com>
 <4F8D2A88.6060309@st.com>
Message-ID: <CACRpkda6fPPsHiCoKAJScOsdGNxFru2baPxj7B88La+axboC-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 10:32 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> This was the place that caused crash for me.
>
> I would apply following change in my patch before sending pull request
> to Arnd.
>
> - ? ? ? *map = kzalloc(sizeof(*map) * count, GFP_KERNEL);
> + ? ? ? *map = kzalloc(sizeof(**map) * count, GFP_KERNEL);

Ah, great you found it!

Thanks,
Linus Walleij
