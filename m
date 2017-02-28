From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 28 Feb 2017 11:58:25 +0200
Subject: [RESEND PATCH v2 0/5] Fix the parse_dt of exynos dsi and remove
 the OF graph
In-Reply-To: <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170228081811epcas5p3c0a8151d94511e47a0e0d2b8787b1fb0@epcas5p3.samsung.com>
 <1488269879-28876-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <CAJKOXPfv8wJ+0L4G_0sB1Qh-svXx4VvNJH_1THSy5SsXuUstzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 10:17 AM, Hoegeun Kwon <hoegeun.kwon@samsung.com> wrote:
> Hi All,
>
> [Resend this v2 patches, because i have missing TO and CC.]
>
> The dsi + panel is a parental relationship, so OF grpah is not needed.
> Therefore, the current dsi_parse_dt function will throw an error,
> because there is no linked OF graph for case such as fimd + dsi +
> panel.
>
> So the 1/5 patch parse the Pll, burst and esc clock frequency
> properties in dsi_parse_dt and modified to create a bridge_node only
> if there is an OF graph associated with dsi.
>
> Also fixed the dts, which depend on the 1/5 patch. So removed the
> ports node and move burst and esc clock frequency properties to the
> parent (DSI node).

Discussions in previous thread lead us to bisectability problem.
Bisectability in regular driver changes is one thing but in case of
driver + DTS the gap is much bigger. DTS will go through separate tree
and branches. How do you want to solve the problem?

Best regards,
Krzysztof
