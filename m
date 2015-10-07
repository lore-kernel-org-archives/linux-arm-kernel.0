From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 7 Oct 2015 11:58:28 -0500
Subject: [PATCH 2/2] pl011: factor our FIFO to TTY code
In-Reply-To: <20151007163557.GN21513@n2100.arm.linux.org.uk>
References: <1298146644-31007-1-git-send-email-linus.walleij@stericsson.com>
 <CAOZdJXVVgd=YTn33VAB2GbfuPkGGapr0C=dN7J+KhdcJuOpKuA@mail.gmail.com>
 <20151007163557.GN21513@n2100.arm.linux.org.uk>
Message-ID: <CAOZdJXWx80Jrjecpi8Tt_To=Tyy-EQK8L53AARj8us7b-hTBBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2015 at 11:35 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> When CREAD is clear, this should cause input to be discarded - except
> in this case, because the bit is cropped by the u16, it'll always be
> accepted.

Ok, I'll submit a patch that changes 'ch' back to an unsigned int.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
