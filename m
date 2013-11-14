From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 14 Nov 2013 14:18:14 -0800
Subject: [PATCH v5 05/14] mtd: nand: pxa3xx: Clear cmd buffer #3
 (NDCB3) on command start
In-Reply-To: <1384464339-6817-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1384464339-6817-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131114221814.GS9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 06:25:30PM -0300, Ezequiel Garcia wrote:
> Command buffer #3 is not properly cleared and it keeps the last
> set value. Fix this by clearing when a command is setup.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Does this have any bugfix ramifications for -stable? You started using
ndcb3 in:

commit 41a634303f8dbf97c8087773b9d66914d2a9c0fd
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Mon Aug 12 14:14:51 2013 -0300

    mtd: nand: pxa3xx: Use 'length override' in ONFI paramater page read

This was merged for 3.12.

Brian
