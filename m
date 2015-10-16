From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 16 Oct 2015 10:26:48 +0530
Subject: [PATCH v4 1/4] dt-bindings: mailbox: Document Hi6220 mailbox
 driver
In-Reply-To: <1444667535-16948-2-git-send-email-leo.yan@linaro.org>
References: <1444667535-16948-1-git-send-email-leo.yan@linaro.org>
 <1444667535-16948-2-git-send-email-leo.yan@linaro.org>
Message-ID: <CABb+yY0S18ShH3+sBnq=mOYMY=f4BNp947cUJae4YPfR=wPGGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:02 PM, Leo Yan <leo.yan@linaro.org> wrote:

> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:          Shall be "hisilicon,hi6220-mbox"
> +- reg:                 Contains the mailbox register address range (base
> +                       address and length); the first item is for IPC
> +                       registers, the second item is shared buffer for
> +                       slots.
>
Is the shared-buffer a part of mailbox controller or just regular
memory that could be used for purposes other than mailbox also? If
latter, please remove it from here.

> +Mailbox client
> +===============
> +
> +"mboxes" and the optional "mbox-names" (please see
> +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
> +of the mboxes property should contain a phandle to the mailbox controller
> +device node and second argument is the channel index. It must be 0 (hardware
> +support only one channel).
>
sorry, what must be 0?  You have MBOX_CHAN_MAX and MBOX_CHAN_NUM as 32
and 2 in the driver.
