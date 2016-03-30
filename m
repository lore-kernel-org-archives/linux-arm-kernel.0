From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 Mar 2016 13:00:06 -0300
Subject: [PATCH V3 0/5] clk: support clocks which requires parent clock on
 during operation
In-Reply-To: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <CAOMZO5D=veSYdWbjksCk-qik3OnJ2i5Wkv8MrCZnTANibeDqLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Tue, Jul 28, 2015 at 10:19 AM, Dong Aisheng
<aisheng.dong@freescale.com> wrote:
> This patch series adds support in clock framework for clocks which operations
> requires its parent clock is on.
>
> Such clock type is initially met on Freescale i.MX7D platform that all clocks
> operations, including enable/disable, rate change and re-parent, requires its
> parent clock on. No sure if any other SoC has the similar clock type.
>
> Current clock core can not support such type of clock well.
>
> This patch introduce a new flag CLK_SET_PARENT_ON to handle this special case
> in clock core that enable its parent clock firstly for each operation and disable
> it later after operation complete.
>
> The most special case is for set_parent() operation which requires both parent,
> old one and new one, to be enabled at the same time during the operation.
>
> The patch series is based on for-next branch of Michael's git:
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

Do you plan to resend this series?
