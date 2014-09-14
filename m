From: tj@kernel.org (Tejun Heo)
Date: Sun, 14 Sep 2014 18:39:11 +0900
Subject: [PATCH] ahci_xgene: Fix the error print invalid resource for APM
 X-Gene SoC AHCI SATA Host Controller driver.
In-Reply-To: <CAOHikRA8LiNkMuzqe-Kgrf4QWbJ_jpXRGHdf+rsrCmq6R0GjDg@mail.gmail.com>
References: <1410508448-25111-1-git-send-email-stripathi@apm.com>
 <1410508448-25111-2-git-send-email-stripathi@apm.com>
 <20140912175014.GA6298@mtj.dyndns.org>
 <CAOHikRA8LiNkMuzqe-Kgrf4QWbJ_jpXRGHdf+rsrCmq6R0GjDg@mail.gmail.com>
Message-ID: <20140914093911.GB9028@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Sep 14, 2014 at 11:36:51AM +0530, Suman Tripathi wrote:
> We can  maintain same piece (IS_ERR(ctx->csr_mux)), then we can do the
> below instead of NULL ??
> 
> ctx->csr_mux = res ? devm_ioremap_resource(dev, res) : ERR_PTR(-EINVAL);

Setting it to NULL on failure would probably make more sense.  No need
to carry around ERR_PTR() value around.

Thanks.

-- 
tejun
