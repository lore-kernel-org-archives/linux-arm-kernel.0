From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 17:03:32 +0800
Subject: [PATCH v2] ARM: imx: Improve the soc revision calculation flow
In-Reply-To: <1517558787-12858-1-git-send-email-ping.bai@nxp.com>
References: <1517558787-12858-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180205090330.GW31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 04:06:27PM +0800, Bai Ping wrote:
> On our i.MX6 SOC, the DIGPROG register is used for representing the
> SOC ID and silicon revision. The revision has two part: MAJOR and
> MINOR. each is represented in 8 bits in the register.
> 
> bits [15:8]: reflect the MAJOR part of the revision;
> bits [7:0]: reflect the MINOR part of the revision;
> 
> In our linux kernel, the soc revision is represented in 8 bits.
> MAJOR part and MINOR each occupy 4 bits.
> 
> previous method does NOT take care about the MAJOR part in DIGPROG
> register. So reformat the revision read from the HW to be compatible
> with the revision format used in kernel.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

Applied, thanks.

I added Aisheng's ACK, since he stated in v1 patch, with his comments
addressed, you can have his ACK tag.

Shawn
