From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 14 Jan 2011 10:51:38 +0530
Subject: [PATCH V3 25/63 resend] Newly erased page read workaround
In-Reply-To: <6187de0568d1ea8a6aeb6c3ca54ac6684bee9973.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<6187de0568d1ea8a6aeb6c3ca54ac6684bee9973.1292833228.git.viresh.kumar@st.com>
Message-ID: <4D2FDD62.4040106@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2010 02:49 PM, Viresh KUMAR wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
> 
> A newly erased page contains ff in data as well as spare area. While reading an
> erased page, the read out ecc from spare area does not match the ecc generated
> by fsmc ecc hardware accelarator. This is because ecc of data ff ff is not ff
> ff. This leads to errors when jffs2 fs erases and reads back the pages to
> ensure consistency.
> 
> This patch adds a software workaround to ensure that the ecc check is not
> performed for erased pages. An erased page is checked by checking data as ff ff.

David,

Does this patch looks fine to you??

--
viresh
