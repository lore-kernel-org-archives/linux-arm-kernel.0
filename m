From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Feb 2016 19:38:15 +0100
Subject: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
In-Reply-To: <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160212183815.GD1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:32:43PM +0530, Sricharan R wrote:
> The definition of i2c_msg says that
> 
> "If this is the last message in a group, it is followed by a STOP.
> Otherwise it is followed by the next @i2c_msg transaction segment,
> beginning with a (repeated) START"
> 
> So the expectation is that there is no 'STOP' bit inbetween individual
> i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
> to inform that there should not be a 'STOP' at the end of transaction.
> The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
> in to one transaction and transfer them. Adding the support for the same.
> 
> This is required for some clients like touchscreen which keeps
> incrementing counts across individual transfers and 'STOP' bit inbetween
> resets the counter, which is not required.
> 
> This patch adds the support in non-dma mode.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Shortened the commit message and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/decc30e7/attachment.sig>
