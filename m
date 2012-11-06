From: loic.pallardy@st.com (Loic PALLARDY)
Date: Tue, 6 Nov 2012 13:53:29 +0100
Subject: [PATCH v2 2/2] mailbox: split internal header from API header
In-Reply-To: <1352170552-29564-3-git-send-email-omar.luna@linaro.org>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
 <1352170552-29564-3-git-send-email-omar.luna@linaro.org>
Message-ID: <50990849.4050003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/06/2012 03:55 AM, Omar Ramirez Luna wrote:
> Now internal structures can remain hidden to the user and just API
> related functions and defines are made available.
>
> Signed-off-by: Omar Ramirez Luna<omar.luna@linaro.org>
> ---
>   drivers/mailbox/mailbox.c |   34 ++++++++++++++++++++++++++++++++
>   drivers/mailbox/mailbox.h |   48 +--------------------------------------------
>   include/linux/mailbox.h   |   22 +++++++++++++++++++
I agree with the file split but I think mailbox framework API should be 
more generic.
omap_ prefix should not be used. mailbox_ prefix will be better.
Message type must be more opened like for example:
struct mailbox_msg {
	int		size;
	unsigned char	header;
	unsigned char	*pdata;
};

Regards,
Loic
