From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 09:44:03 +0100
Subject: [PATCH v4 05/10] ARM: tegra: Provide clock for only one PWM
 controller
In-Reply-To: <4F67E8E4.7000604@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-6-git-send-email-thierry.reding@avionic-design.de>
 <4F67E8E4.7000604@wwwdotorg.org>
Message-ID: <20120320084403.GB20249@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> > A subsequent patch will add a generic PWM API driver for the Tegra PWFM
> > controller, supporting all four PWM devices with a single PWM chip. The
> > device will be named tegra-pwm and only one clock needs to be provided.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> ...
> > -	CLK_DUPLICATE("pwm", "tegra_pwm.0", NULL),
> > -	CLK_DUPLICATE("pwm", "tegra_pwm.1", NULL),
> > -	CLK_DUPLICATE("pwm", "tegra_pwm.2", NULL),
> > -	CLK_DUPLICATE("pwm", "tegra_pwm.3", NULL),
> > +	CLK_DUPLICATE("pwm", "tegra-pwm", NULL),
> 
> I thought harder about this: Why not delete /all/ the CLK_DUPLICATE()s
> for PWM, and change the second parameter to PERIPH_CLK for PWM from
> "pwm" to "tegra-pwm"?

I think that should work. I'll retest and will update the patch accordingly.
I assume that you're Acked-by will remain valid after those changes?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/a12bb98b/attachment-0001.sig>
