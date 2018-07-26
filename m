From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 15:11:39 +0530
Subject: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
In-Reply-To: <20180726065331.6186-2-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de>
Message-ID: <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
<o.rempel@pengutronix.de> wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> Mailbox devices may have only one channel which means the mbox-cells
> at least 1 does not make sense for this type devices. Let's remove
> that limitation to allow the mbox-cells to be equal to 0.
>
OK

But please realise that you'll have to write more code -- implement
your own of_xlate() callback.
Most developers would prefer to call the only channel as channel
number 0, and use the common of_xlate implementation.

-jassi
