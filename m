From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Mar 2017 09:34:35 -0500
Subject: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
In-Reply-To: <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
 <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
Message-ID: <CAL_Jsq+1f2pHEy7=2Q7xGYYJjuQk3rLHH4pPTKRVN4QTtSr4Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> it jumps to the parent node without examining the child node.
> also with that, it throws "no dma-ranges found for node"
> for pci dma-ranges.
>
> this patch fixes device node traversing for dma-ranges.

What's the DT look like that doesn't work?

dma-ranges is supposed to be a bus property, not a device's property.
So looking at the parent is correct behavior generally.

Rob
