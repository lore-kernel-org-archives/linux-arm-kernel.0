From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 13:13:15 -0400
Subject: [PATCH] mmc: mvsdio: use dev_*() API instead of pr_*() API
In-Reply-To: <1363792181-26512-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 20 Mar 2013 16:09:41 +0100")
References: <1363792181-26512-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87k3ozl5n8.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 20 2013, Thomas Petazzoni wrote:
> The mvsdio driver was already using some dev_*() functions to print
> some messages, but still using pr_*() functions for some others. This
> patch converts all messages to use dev_*() functions.
>
> Many of the pr_*() function calls were printing the output of
> mmc_hostname() to preprend the message with an identifier for the
> device. Since the dev_*() functions do that automatically, this patch
> also gets rid of those string prefixes.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is for 3.10.

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
