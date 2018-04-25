From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 25 Apr 2018 11:17:00 -0700
Subject: [PATCH/RFC v2] ARM: shmobile: defconfig: Enable LPAE
In-Reply-To: <1524672875-14130-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1524672875-14130-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <90afbd8b-462d-8484-74e8-b983a9803fc4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2018 09:14 AM, Fabrizio Castro wrote:
> On iWave's iwg20m DDR1 512MB memory cannot be accessed with 32-bit
> addresses, hence we need LPAE.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
> This information is mentioned in the "RZ/G Series User?s Manual: Hardware",
> Chapter 2, Area Map. Is this patch going to break the functionality of other
> boards? Comments welcome.

LPAE is not supported by all Cortex-A class cores, for instance
Cortex-A9 does not support LPAE, if you have boards using such cores,
then this would result in a kernel that would not boot on these
platforms. Can that be a problem with the shmobile_defconfig?
-- 
Florian
