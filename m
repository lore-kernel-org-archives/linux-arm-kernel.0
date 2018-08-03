From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Aug 2018 18:24:41 +0530
Subject: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
Message-ID: <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
>
1) TXDONE_BY_BLOCK flag :-
        Have you tried setting the flag mbox_chan->mbox_client->tx_block ?

2) Implementing TEGRA_HSP_MBOX_TYPE_SM :-
       In mailbox framework, a controller is a collection of identical
channels. That is, instances of the same class.
       So ideally, in probe you should populate a controller for each
type of channel, i.e, DB, SM, SS and AS.
