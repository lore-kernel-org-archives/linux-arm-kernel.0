From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 02 Feb 2018 12:24:49 +0100
Subject: [PATCH v2] ARM: imx: Improve the soc revision calculation flow
In-Reply-To: <1517558787-12858-1-git-send-email-ping.bai@nxp.com>
References: <1517558787-12858-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1517570689.1923.13.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-02-02 at 16:06 +0800, Bai Ping wrote:
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

Tested here with a i.MX6Q (marked as 'D' in part number last character).

If you want, you can add my

Tested-by: Christoph Fritz <chf.fritz@googlemail.com>
