From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 5 Aug 2014 13:12:57 -0700
Subject: [PATCH 8/8] msm: scm: Move the scm driver to drivers/soc/qcom
In-Reply-To: <alpine.OSX.2.03.1408042203100.87047@linaro.org>
References: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
 <1407202310-3359-9-git-send-email-sboyd@codeaurora.org>
 <alpine.OSX.2.03.1408042203100.87047@linaro.org>
Message-ID: <CAJAp7OiXW1A-H4io2kST_Y6LdVP+EYkXoU3GaWTRt_+CyXruQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 4, 2014 at 9:07 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Mon, 4 Aug 2014, Stephen Boyd wrote:
[...]
> Could we move scm-boot.c as well to drivers/soc/qcom and scm-boot.h to include/soc/qcom ?

Yes, we can do that.

But as of now we seem to only have one caller of this wrapper, so
maybe we could move the functionality into platsmp.c and drop the file
instead?

I looked at this a while back and was considering suggesting that we
move the scm access behind firmware_ops, but then we should probably
also extend the ops struct with all the needed ops related to firmware
loading and other things; so I'm not sure if it's a beneficial move.

Regards,
Bjorn
