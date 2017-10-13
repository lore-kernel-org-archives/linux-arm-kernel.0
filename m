From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 13 Oct 2017 18:35:59 -0500
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <CACRpkdYYp5TSM1QV-f+FmbwzY_ittgW-4MuXiZ9NW694GoMwKQ@mail.gmail.com>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
 <20171002174414.GL1165@minitux>
 <9f28c9dd-6277-6c75-1186-a834e15c5346@codeaurora.org>
 <CACRpkdYYp5TSM1QV-f+FmbwzY_ittgW-4MuXiZ9NW694GoMwKQ@mail.gmail.com>
Message-ID: <2be95dec-5e53-71b4-1b08-3e8dd45ca30c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2017 06:07 AM, Linus Walleij wrote:
> I mean that you add
> unsigned long *line_valid_mask;
> to struct gpio_chip using the same type of logic
> as .irq_valid_mask. The mask should be optional.

Hmmm okay

> Then the operation gpiod_get[_index]() will FAIL if the
> line is not valid.

Just to be clear, you want gpiod_get_index() to check line_valid_mask 
(if present) and return -ENODEV if not valid?

> There is no need to check on every operation, there should
> be no way to get a handle on the pin any other way.
> 
> All new code should be using descriptors at this point so we
> only need to design for that case.

Ok, I will check this.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
