From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 1 Mar 2016 15:43:01 -0700
Subject: [PATCH net-next V2 03/16] net: fec: pass txq to fec_enet_tx_queue
 instead of queue_id
In-Reply-To: <CAHrpEqQdBqUwfrHL=dHGszEeU-pRo9mmOyuTy6aaw3QMBdkqUg@mail.gmail.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-4-git-send-email-troy.kisky@boundarydevices.com>
 <CAHrpEqSyuToC6QFEZygO0YyA=gV2cZEtkpRJMeZFOjhgTLdexQ@mail.gmail.com>
 <56D60EDE.7090100@boundarydevices.com>
 <CAHrpEqQdBqUwfrHL=dHGszEeU-pRo9mmOyuTy6aaw3QMBdkqUg@mail.gmail.com>
Message-ID: <56D61AF5.5030507@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/1/2016 3:26 PM, Zhi Li wrote:
> On Tue, Mar 1, 2016 at 3:51 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
>> True, but fec_txq/fec_rxq is called in a loop.
> 
> netdev_priv(ndev) is that pointer move.
> dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN)
> 
> Modem compiler can handle it greatly.
> 
> You can't get any valuable performance gain by that.
> 
> The main time of CPU is call dma_map_xxx.
> 
> best regards
> Frank Li
> 

Ok, I'll revert that part.
