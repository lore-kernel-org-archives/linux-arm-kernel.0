From: briannorris@chromium.org (Brian Norris)
Date: Thu, 25 Jan 2018 14:47:21 -0800
Subject: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
In-Reply-To: <20180125155504.8611-1-philippe.cornu@st.com>
References: <20180125155504.8611-1-philippe.cornu@st.com>
Message-ID: <CA+ASDXOLYaL1zT-K0FvVTFGQ2BA12eHkrZw_mau50aUBdy=vhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 7:55 AM, Philippe Cornu <philippe.cornu@st.com> wrote:
> The "adjusted_mode" clock value (ie the real pixel clock) is more
> accurate than "mode" clock value (ie the panel/bridge requested
> clock value). It offers a better preciseness for timing
> computations and allows to reduce the extra dsi bandwidth in
> burst mode (from ~20% to ~10-12%, hw platform dependant).
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Note: This patch replaces "drm/bridge/synopsys: dsi: add optional pixel clock"

These two appear to be the same for my cases, but at least nothing breaks:

Tested-by: Brian Norris <briannorris@chromium.org>
