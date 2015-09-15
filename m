From: agross@codeaurora.org (Andy Gross)
Date: Tue, 15 Sep 2015 12:58:55 -0500
Subject: [PATCH] ARM: Remove __ref on hotplug cpu die path
In-Reply-To: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
References: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150915175855.GA18435@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 05:23:17PM -0700, Stephen Boyd wrote:
> Now that __cpuinit has been removed, the __ref markings on these
> functions are useless. Remove them. This also reduces the size of
> the multi_v7_defconfig image:
> 
> $ size before after
>    text    data     bss     dec     hex filename
>    12683578        1470996  348904 14503478         dd4e36 before
>    12683274        1470996  348904 14503174         dd4d06 after
> 
> presumably because now we don't have to jump to code in the
> .ref.text section and/or the noinline marking is removed.

<snip>

Acked-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
