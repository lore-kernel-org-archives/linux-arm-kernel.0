From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Nov 2011 10:28:44 +0100
Subject: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
In-Reply-To: <4ECB5D2E.1000906@st.com>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
 <4ECB5D2E.1000906@st.com>
Message-ID: <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 9:28 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
>> ? ? ? if (list_empty(&pl022->queue) || !pl022->running) {
>> + ? ? ? ? ? ? if (pl022->busy) {
>> + ? ? ? ? ? ? ? ? ? ? pm_runtime_put(&pl022->adev->dev);
>> + ? ? ? ? ? ? }
>
> We used to get warnings from checkpatch, for single line code inside {}.
> Don't we get them anymore?

It's driven by heuristics, I think it only warns on the first level since
elsewhere you may want braces for readability.

But I'll take it out when I add you Reviewed-by...

Linus
