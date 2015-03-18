From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 13:46:53 +0100
Subject: [PATCH 2/2] i2c: busses with dynamic ids should start after
 fixed ids for DT
In-Reply-To: <1426177093-26820-3-git-send-email-wsa@the-dreams.de>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
 <1426177093-26820-3-git-send-email-wsa@the-dreams.de>
Message-ID: <20150318124653.GC3580@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 05:17:59PM +0100, Wolfram Sang wrote:
> Make sure dynamic ids do not interfere with fixed ones and let them
> start after the highest fixed id. This patch might cause different
> bus-numbers for dynamic ids, however it fixes a bug. Assume:
> 
> - fixed id0 defers probe
> - fixed id1 succeeds and registers a muxed bus with dynamic id
> - muxed bus gets id0
> - fixed id0 wants to probe again, but its fixed id is gone now
> - fixed id0 probe fails
> 
> With this patch, the fixed ids are always reserved in the DT case.
> For legacy board init, we already have a mechanism like this in
> i2c_register_board_info().
> 
> Reported-by: Bob Feretich <bob.feretich@rafresearch.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Fixed the checkpatch warning and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/5a8ad23e/attachment-0001.sig>
