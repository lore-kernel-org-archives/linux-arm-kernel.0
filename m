From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 19:09:18 +0100
Subject: [PATCH 0/3] arm64 fixes following support for hardware AF/DBM
In-Reply-To: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
References: <1441992122-19888-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <55F318CE.2070103@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 11/09/15 18:21, Catalin Marinas wrote:
> It seems that the recent patch for handling hardware updates to the AF
> and dirty bits also breaks hardware without such feature because of
> changes to how a pte is detected as dirty. The first patch fixes the
> non-DBM hardware case. The second is fixes losing of the dirty
> information for hardware DBM (as a consequence of the first patch,
> otherwise a pte was pretty much always dirty anyway). The third patch is
> a clean-up.

Thank you, this series is fixing the userspace issue on X-gene:

Tested-by: Julien Grall <julien.grall@citrix.com>

Regards,

-- 
Julien Grall
