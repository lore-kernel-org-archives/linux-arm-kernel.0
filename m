From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Feb 2015 19:37:02 +0000
Subject: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
In-Reply-To: <54D5164A.30503@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org>
 <54D3EB29.4090007@codeaurora.org>
 <20150206004210.GB8670@n2100.arm.linux.org.uk>
 <54D41A60.8040702@codeaurora.org>
 <20150206133920.GC8670@n2100.arm.linux.org.uk>
 <54D5164A.30503@codeaurora.org>
Message-ID: <20150206193702.GD8670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 11:30:18AM -0800, Stephen Boyd wrote:
> Why don't we make the legacy lookup more specific and actually indicate
> "internal" for the con_id? Then the external clock would fail to be
> found, but we can detect that case and figure out that it's not due to
> probe defer, but instead due to the fact that there really isn't any
> mapping. It looks like the code is already prepared for this anyway.

We _could_, and that would solve this specific issue, but I'd suggest
coccinelle is used to locate any other similar instances of this.

As I'm allergic to coccinelle (or coccinelle is allergic to me since
I never seem to be able to get it to do what I want...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
