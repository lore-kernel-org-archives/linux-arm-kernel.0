From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 7 Feb 2017 00:27:23 -0800
Subject: [PATCH v2 2/5] async_tx: Handle DMA devices having support for
 fewer PQ coefficients
In-Reply-To: <1486455406-11202-3-git-send-email-anup.patel@broadcom.com>
References: <1486455406-11202-1-git-send-email-anup.patel@broadcom.com>
 <1486455406-11202-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <CAPcyv4gbV1yf52JrejW+Dn3wOPn7Er+8HWdu2qsW0+Qm+cRr9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 12:16 AM, Anup Patel <anup.patel@broadcom.com> wrote:
> The DMAENGINE framework assumes that if PQ offload is supported by a
> DMA device then all 256 PQ coefficients are supported. This assumption
> does not hold anymore because we now have BCM-SBA-RAID offload engine
> which supports PQ offload with limited number of PQ coefficients.
>
> This patch extends async_tx APIs to handle DMA devices with support
> for fewer PQ coefficients.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

I don't like this approach. Define an interface for md to query the
offload engine once at the beginning of time. We should not be adding
any new extensions to async_tx.
