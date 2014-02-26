From: tj@kernel.org (Tejun Heo)
Date: Wed, 26 Feb 2014 08:51:08 -0500
Subject: [PATCH v2 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140225144141.GA26788@htj.dyndns.org>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <1393328481-7251-3-git-send-email-lee.jones@linaro.org>
 <20140225144141.GA26788@htj.dyndns.org>
Message-ID: <20140226135108.GC17302@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 09:41:41AM -0500, Tejun Heo wrote:
> On Tue, Feb 25, 2014 at 11:41:21AM +0000, Lee Jones wrote:
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: linux-ide at vger.kernel.org
> > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied to libata/for-3.15 w/ missing "\n" added to dev_err() in
> st_ahci_suspend().

Reverted from libata/for-3.15 due to build failure.  Please drop
ahci_platform_put_resource() calls.  ahci_platform now manages it
through devres.

-- 
tejun
