From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 19 Aug 2015 17:51:23 -0500
Subject: [PATCH 1/3] [v2] hvc_dcc: don't ignore errors during
 initialization
In-Reply-To: <20150810094859.GF1604@arm.com>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <20150810094859.GF1604@arm.com>
Message-ID: <55D5086B.7050907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 04:48 AM, Will Deacon wrote:
>> >
>> >  static int __init hvc_dcc_console_init(void)
>> >  {
>> >+	int ret;
>> >+
>> >+	/* This always runs on boot core */
> Does this really "always run on the boot core"? I couldn't find anything
> suggesting that console_init is limited in that regard.

So this is a left-over comment from some other code that actually cared 
what code this function runs on.  I've removed the comment.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
