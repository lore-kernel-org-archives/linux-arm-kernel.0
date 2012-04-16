From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 10:03:34 -0600
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <1334586289-13078-1-git-send-email-b29396@freescale.com>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>
Message-ID: <4F8C42D6.2000607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 08:24 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Remove dummy state user interface and handle it totally in core.
> This can make it more easy to use by platforms which has neither pinctrl
> driver support nor dt support.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

I think this is the wrong direction.

I specifically want people to think about which drivers require what
pinctrl states to be defined, and what their content should be, and
hence explicitly define dummy states when it's appropriate. This patch
prevents that.
