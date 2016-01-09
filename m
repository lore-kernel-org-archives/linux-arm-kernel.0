From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jan 2016 22:36:11 -0600
Subject: [V5, 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs without a
 stop bit
In-Reply-To: <1447760727-4897-4-git-send-email-sricharan@codeaurora.org>
References: <1447760727-4897-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160109043611.GB4616@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:15:24PM +0530, Sricharan R wrote:
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

Reviewed-by: Andy Gross <andy.gross@linaro.org>
