From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 14:44:39 +0000
Subject: [PATCH V5 41/63] ST SPEAr: replace readl, writel with
	readl_relaxed, writel_relaxed in uncompress.h
In-Reply-To: <c792c9602552d0650cd55c4f724257ad46b79cc8.1295499395.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<c792c9602552d0650cd55c4f724257ad46b79cc8.1295499395.git.viresh.kumar@st.com>
Message-ID: <20110219144439.GG29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:56:19PM +0530, Viresh Kumar wrote:
> readl also calls outer cache maintainance operations which are not available
> during Linux uncompression. This patch replaces readl, writel with readl_relaxed
> and writel_relaxed.

Shouldn't this be near the start of the series?

Also, would:

"SPEAr: replace readl, writel with relaxed versions in uncompress.h

readl() and writel() calls the outer cache maintainance operations
which are not available during Linux uncompression. This patch replaces
readl() and writel() with readl_relaxed() and writel_relaxed() to avoid
the link time errors."

be a better patch description?
