From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 31 Oct 2013 18:03:09 -0200
Subject: [PATCH] clk: Properly initialize reference count
In-Reply-To: <1383220962-26836-1-git-send-email-treding@nvidia.com>
References: <1383220962-26836-1-git-send-email-treding@nvidia.com>
Message-ID: <CAOMZO5AmQV1yv-4PBfs86cJ27K4gTFS0BXa=JYN+LSaV-pAcmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:02 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Commit a336ed7 (clk: Implement clk_unregister()) initializes the kref in
> clk_set_parent(), which is obviously the wrong place. Further research
> shows that the original patches initialized it correctly, so it probably
> ended up in clk_set_parent() by mistake during manual application of the
> patch.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
