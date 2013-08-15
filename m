From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Aug 2013 21:20:44 +0200
Subject: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
In-Reply-To: <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
Message-ID: <20130815192044.GD12162@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> For at91 boards, there are different IPs for adc. Different IPs has
> different STARTUP & PRESCAL mask in ADC_MR.
> 
> This patch introduce the multiple compatible string for those
> different IPs.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Overall it looks like the right ways, but I think we can take it a step
further.

I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
atmel,adc-status-register, atmel,adc-trigger-register properties (and
probably the triggers as well description as well).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/5a870082/attachment.sig>
