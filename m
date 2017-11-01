From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 1 Nov 2017 15:17:09 -0700
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
Message-ID: <20171101221709.GB28761@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 01 Nov 11:15 PDT 2017, Sudeep Holla wrote:
> 
>  80         writel_relaxed(msg->cmd, mb->mbox_base +
> MAILBOX_A2B_CMD(chans->idx));
>  81         writel_relaxed(msg->rx_size, mb->mbox_base +
> 
>  82                        MAILBOX_A2B_DAT(chans->idx));
> 
>  83

This is just terrible, using the void *mssg to pass a struct which is
interpreted by the controller removes any form of abstraction provided
by the framework.

In my view the void *mssg should point to the data to be written in the
mailbox register, and hence might be of different size - but only of
native type.

Regards,
Bjorn
