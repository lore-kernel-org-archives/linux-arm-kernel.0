From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 12 Mar 2015 12:57:08 +0200
Subject: [PATCH 3.18 stable] ARM: mvebu: do not register custom DMA
 operations when coherency is disabled
In-Reply-To: <1426157350-23120-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426157350-23120-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150312105708.GM2177@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Mar 12, 2015 at 11:49:10AM +0100, Thomas Petazzoni wrote:
> This patch is a partial backport of commit ef01c6c36bb8 ("ARM: mvebu:
> remove Armada 375 Z1 workaround for I/O coherency"). This commit was
> merged in v3.19, so kernel versions later than v3.19 are not affected
> by the problem that this commit fixes.
> 
> It does make a lot of sense to backport this commit entirely, since it

"It does not" maybe?

> is mainly removing some no longer useful code. However, this commit is
> also making sure that the bus_register_notifier that register the
> custom DMA operations that should be used for HW I/O coherency does
> not get registered when said HW I/O coherency is not enabled.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
