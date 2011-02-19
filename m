From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 19 Feb 2011 22:46:53 +0530
Subject: [PATCH V5 41/63] ST SPEAr: replace readl, writel with
	readl_relaxed, writel_relaxed in uncompress.h
In-Reply-To: <20110219144439.GG29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<c792c9602552d0650cd55c4f724257ad46b79cc8.1295499395.git.viresh.kumar@st.com>
	<20110219144439.GG29493@n2100.arm.linux.org.uk>
Message-ID: <AANLkTiku32iA2qXWBWY1T8+p3DTnie-CnJ-pcW0-U73P@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2011 at 12:56:19PM +0530, Viresh Kumar wrote:
>> readl also calls outer cache maintainance operations which are not
>> available
>> during Linux uncompression. This patch replaces readl, writel with
>> readl_relaxed
>> and writel_relaxed.
>
> Shouldn't this be near the start of the series?
>

Yes.

> Also, would:
>
> "SPEAr: replace readl, writel with relaxed versions in uncompress.h
>
> readl() and writel() calls the outer cache maintainance operations
> which are not available during Linux uncompression. This patch replaces
> readl() and writel() with readl_relaxed() and writel_relaxed() to avoid
> the link time errors."
>
> be a better patch description?
>

Obviously. Will take care of such things next time we send a patch.

--
viresh
