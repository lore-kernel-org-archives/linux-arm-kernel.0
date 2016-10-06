From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 6 Oct 2016 18:40:04 +0530
Subject: [PATCH v14 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1475758897.4102.31.camel@mtksdaap41>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-3-git-send-email-hs.liao@mediatek.com>
 <1475204778.13398.28.camel@mtksdaap41>
 <1475225778.25044.35.camel@mtksdaap41> <1475226691.13398.35.camel@mtksdaap41>
 <1475228829.3658.1.camel@mtksdaap41> <1475636064.21937.25.camel@mtksdaap41>
 <CAJe_ZhcXw1-MOEiiix5VTtKEVr9Z23s_OyikboDYCd0RQwS5pg@mail.gmail.com>
 <1475670705.335.27.camel@mtksdaap41>
 <CAJe_ZheeEe0xEj733pxr4q=-YzxKHgRM4MMPDJNHa9uRC9Q2zA@mail.gmail.com>
 <1475758897.4102.31.camel@mtksdaap41>
Message-ID: <CAJe_ZheptRQSmQp2gagqUyXqkOpi1qaTo8QPDTFpQ-+62B6kUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2016 at 18:31, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:

> Back to our original statement, we need to flush all tasks to queue
> in GCE HW; i.e. we need to use mbox_client_txdone after
> mbox_send_message, or send tx_done once mailbox controller receive
> message (task). However, we still need a way to notice done tasks to
> clients. Currently, we don't have a good way to call callback in mailbox
> framework. Therefore, CMDQ driver has its owner callback functions.
>
mbox_client_txdone() is called by the client driver when only it knows
the messages has been transmitted (i.e your submitted tasks are done).
Obviously the client driver should do any callbacks to its users
upstream.
