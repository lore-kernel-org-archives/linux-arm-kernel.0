From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Jun 2013 19:16:43 +0800
Subject: [PATCH v2 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1708070.4u00OSumQU@linux-5eaq.site>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
 <1372066925-23579-4-git-send-email-ming.lei@canonical.com>
 <1708070.4u00OSumQU@linux-5eaq.site>
Message-ID: <CACVXFVP9pUkLsHxTZS=j-jWGiOiiAyefLpAtM9PK9Hdz1S7guQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 6:28 PM, Oliver Neukum <oliver@neukum.org> wrote:
> On Monday 24 June 2013 17:42:04 Ming Lei wrote:
>> This patch improves this above situation, and the qh will wait for 5
>> milliseconds before being unlinked from hardware, if one URB is submitted
>> during the period, the qh is move out of unlink wait list and the
>> interrupt transfer can be scheduled immediately, not like before: the
>> transfer is only linked to hardware until previous unlink is completed.
>
> It seems to me that this logic should be used only if the URB completed
> without error.

The current completed URB with error  doesn't mean the later submitted
URB will complete with error, so I don't think the logic is related with URB
completion error.

Thanks,
--
Ming Lei
