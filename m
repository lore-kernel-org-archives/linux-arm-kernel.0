From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 25 Nov 2010 10:51:36 +0200
Subject: [PATCH v2] Add call to non-crashing cores through IPI
In-Reply-To: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20101125085136.GM14080@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 09:28:28AM +0100, Per Fransson wrote:
> v2 changes:
> * the interrupts of the calling core are no longer disabled
>   before performing the IPI

This version information should go after the commit message below
the '---' line.

> ---
> 
> When kexec is used to start a crash kernel the other cores
> are notified. These non-crashing cores will save their state
> in the crash notes and then do nothing.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>

I tested this on UP machine (I don't have access to any SMP hardware) -
it didn't break anything and the crashdump works perfectly.

Regards,
MW
