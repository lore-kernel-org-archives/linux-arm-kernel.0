From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 31 Jan 2014 12:27:39 +0000
Subject: [PATCH 1/4] ARM: STi: add stid127 soc support
In-Reply-To: <201401301939.08302.arnd@arndb.de>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-2-git-send-email-patrice.chotard@st.com>
 <201401301935.16463.arnd@arndb.de> <201401301939.08302.arnd@arndb.de>
Message-ID: <52EB96BB.6070800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On 30/01/14 18:39, Arnd Bergmann wrote:
> Actually reading the code in this file shows that the L2 cache
> initialization is the only nonstandard thing in there. We should
> really find a way to get rid of the entire function.
I think this will get rid of lot of code left in board-dt.

> 
> Sorry if I missed the initial review, but can you explain
> why this is needed to start with?
On ST SoCs the default value for L2 AUX_CTRL register is 0x0, so we  set
the way-size explicit here.

Thanks,
srini
