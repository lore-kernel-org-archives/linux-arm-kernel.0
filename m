From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Sep 2017 00:04:22 -0700
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
Message-ID: <20170919070422.GI3349@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07, Timur Tabi wrote:
> First patch allows for for pinctrl-msm to understand GPIO groups with
> no pins.  Such pins are "hidden" and can't be exported or accessed.
> 
> Second patch updates the QDF2xxx driver to take advantage of all that.
> 
> v5:
>  Since gpiochip_add_data no longer requests GPIOs before scanning for
>  the direction (that patch was reverted), pinctrl-msm.c now specifically
>  checks for special case.

Can we add a new gpiochip op that checks for "availability". I
read the other thread where the change was reverted (please add a
pointer next time), and as I understand it the gpio request
method can also change the muxing to a gpio instead of something
else. Perhaps we can add another hook for our purposes here that
tells gpiolib that the gpio is not usable and to skip it. The
semantics would be clear, it's just about probing availability of
this pin as a gpio and doesn't mux any pins.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
