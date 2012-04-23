From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 18:03:33 +0530
Subject: [PATCH V2 2/6] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <e5af9ce5a6b0621b6f18af8206d6c43da1e35e52.1334852394.git.viresh.kumar@st.com>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <e5af9ce5a6b0621b6f18af8206d6c43da1e35e52.1334852394.git.viresh.kumar@st.com>
Message-ID: <CAOh2x==kMOQDjz4pTeMHFVj60=w4666bFnYWZoUwfM+hWHm5eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/12, Viresh Kumar <viresh.linux@gmail.com> wrote:
> All SPEAr SoC's contain Auxiliary Synthesizers. Their Fout is derived based
> on
> values of eq, x and y.
>
> Fout from synthesizer can be given from two equations:
> Fout1 = (Fin * X/Y)/2		EQ1
> Fout2 = Fin * X/Y		EQ2
>
> This patch adds in support for this type of clock.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/clk/spear/Makefile        |    2 +-
>  drivers/clk/spear/clk-aux-synth.c |  187

Hi Mike,

What are your plans for this patchset? Can you push this in v3.5?
SPEAr dependency patches are already pushed by Arnd and are present
in linux-next now.

Please squash following fixup with this patch while applying:

From: Viresh Kumar <viresh.kumar@st.com>
Date: Fri, 20 Apr 2012 17:08:40 +0530
Subject: [PATCH] fixup! SPEAr: clk: Add Auxiliary Synthesizer clock

Set aux->masks to masks if it is valid.

---
 drivers/clk/spear/clk-aux-synth.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c
b/drivers/clk/spear/clk-aux-synth.c
index 1a7ab7d..e01a350 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -154,6 +154,8 @@ struct clk *clk_register_aux(const char *aux_name,
const char *gate_name,
 	/* struct clk_aux assignments */
 	if (!masks)
 		aux->masks = &default_aux_masks;
+	else
+		aux->masks = masks;

 	aux->reg = reg;
 	aux->rtbl = rtbl;

--
Viresh
