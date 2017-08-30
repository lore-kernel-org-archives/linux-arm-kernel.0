From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 30 Aug 2017 09:22:55 -0500
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <20170830161730.41919554@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com> <20170830161730.41919554@windsurf.lan>
Message-ID: <442accaa-15a0-4efb-4e5c-cebca7140213@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/17 9:17 AM, Thomas Petazzoni wrote:
> So what Timur is saying perhaps is that
> mvebu_pinmux_gpio_request_enable() shouldn't be changing the type of
> muxing, and therefore shouldn't be calling mvebu_pinconf_group_set().
> 
> However, even the "reference" pinctrl-single.c implementation does it,
> in pcs_request_gpio().
> 
> Am I missing something ?

No, that's it.  The question is, what exactly should the 'request' 
function do?  Should it be modifying the hardware to satisfy the 
request?  When I wrote my patch, I assumed that it wouldn't.  I thought 
that request simply answered the question, "can I touch this GPIO"?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
