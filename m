From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 24 May 2013 11:20:06 +0200
Subject: [PATCH 4/6] pinctrl: samsung: Add support for SoC-specific
 suspend/resume callbacks
In-Reply-To: <CACRpkdY-d3YYLJoWydakbT7P4wnBAK2XL7X0Fs0EcNSFakpUDw@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-5-git-send-email-t.figa@samsung.com>
 <CACRpkdY-d3YYLJoWydakbT7P4wnBAK2XL7X0Fs0EcNSFakpUDw@mail.gmail.com>
Message-ID: <22452279.DN7eJUzGA7@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Friday 24 of May 2013 11:07:41 Linus Walleij wrote:
> On Fri, May 17, 2013 at 6:24 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > SoC-specific driver might require additional save and restore of
> > registers. This patch adds pair of SoC-specific callbacks per pinctrl
> > device to account for this.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Patch applied for fixes.

Thanks.

> Hm this is quite a lot of code for "fixes", can you confirm that
> the system is really unusable without all these patches?

Well, it is something that should have been already sent as a fix for 3.8, when 
this pin control driver was added, because since then suspend/resume has been 
broken on DT-enabled Exynos boards.

Without this, suspending the board and then trying to wake it up is rather 
unpredictable, leading usually to board reset, interrupt storm or at least 
some devices failing to resume.

Best regards,
-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics
