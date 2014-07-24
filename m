From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 24 Jul 2014 14:29:09 +0200
Subject: [alsa-devel] DMA engine API issue
In-Reply-To: <28702317.aD0C1Ga3DS@avalon>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87d2cwvmxa.wl%kuninori.morimoto.gx@gmail.com> <3361994.F0HgAeJkR9@avalon>
 <28702317.aD0C1Ga3DS@avalon>
Message-ID: <53D0FC15.6050601@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2014 01:07 PM, Laurent Pinchart wrote:
[...]
> Let's start by answering the background question and updating the DMA engine
> API documentation once and for good : in which context are drivers allowed to
> call the prep, tx_submit and issue_pending functions ?
>

I think the expectation is that these functions can be called in any 
context. Maybe what's missing is a way to tell the DMA engine driver to get 
ready and that it is going to be used very soon. This could be done from the 
sound devices open() callback.

- Lars
