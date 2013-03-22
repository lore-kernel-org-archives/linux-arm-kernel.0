From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 13:18:13 -0400
Subject: [PATCH for 3.10 v2] mmc: mvsdio: use dev_*() API instead of
 pr_*() API
In-Reply-To: <1363959441-30744-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Fri, 22 Mar 2013 14:37:21 +0100")
References: <1363959441-30744-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87zjxvjqui.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 22 2013, Thomas Petazzoni wrote:
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
>
> Changes between v1 and v2:
>
>  * Fix incorrect format string. A "%s" was left, even though the
>    mmc_hostname() argument was removed due to the conversion to the
>    dev_*() API.

Thanks, I've updated to v2 in mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
