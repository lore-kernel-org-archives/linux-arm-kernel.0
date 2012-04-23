From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 23 Apr 2012 10:52:45 -0500
Subject: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting
 module level context status
In-Reply-To: <1334913591-26312-5-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
 <1334913591-26312-5-git-send-email-t-kristo@ti.com>
Message-ID: <4F957ACD.2040103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On 04/20/2012 04:19 AM, Tero Kristo wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> On OMAP4 most modules/hwmods support module level context status. On
> OMAP3 and earlier, we relyed on the power domain level context status.
> Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
> hwmods already have a valid 'context_offs' populated in .prcm structure.

Is it necessary to add another flag? Can't we just check if context_offs
is non-zero? Would save adding a lot more lines to an already large file
:-)

Cheers
Jon
