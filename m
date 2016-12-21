From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Dec 2016 18:08:24 -0200
Subject: [PATCH 1/2] i.MX31: ipu: Make sure the interrupt routine checks
 all interrupts.
In-Reply-To: <1482182934-18559-2-git-send-email-lilja.magnus@gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482182934-18559-2-git-send-email-lilja.magnus@gmail.com>
Message-ID: <CAOMZO5C61gfL95sW=r5RLxFaDSeb34FuFSx8Pj=J2-WqYD1qaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Mon, Dec 19, 2016 at 7:28 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:
> Commit 3d8cc00073d6750ffe883685e49b2e4a0f596370 consolidated the two

The standard form to specify a commit is 3d8cc00073d6 ("dmaengine:
ipu: Consolidate duplicated irq handlers")

> interrupts routines into one, but the remaining interrupt routine only
> checks the status of the error interrupts, not the normal interrupts.
>
> This patch fixes that problem (tested on i.MX31 PDK board).
>
> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>

Patch looks good, but I have some suggestions:

- Subject should start with dmaengine, so something like:
Subject: dmaengine: ipu: Make sure the ....

- You sent these two patches on a series, but as they touch different
subsystems they could be sent separately, each one to the proper
maintainer. For dmaengine the maintainer is Vinod. Hint: you can run
./scripts/get_maintainer.pl on your patch and it will list the
maintainer and lists the patches should be sent to.

You should also add a Fixes tag above your Signed-off-by like this:
Fixes: 3d8cc00073d6 ("dmaengine: ipu: Consolidate duplicated irq handlers")
Cc: <stable@vger.kernel.org> # 4.3.x
