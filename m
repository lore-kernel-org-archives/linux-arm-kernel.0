From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:14:46 +0530
Subject: [PATCH V2 5/7] ARM: SPEAr3xx: Add device-tree support to SPEAr3xx
 architecture
In-Reply-To: <201203290753.04758.arnd@arndb.de>
References: <cover.1332926608.git.viresh.kumar@st.com>
 <201203281227.32299.arnd@arndb.de> <4F740386.2080509@st.com>
 <201203290753.04758.arnd@arndb.de>
Message-ID: <4F743D1E.9030209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2012 1:23 PM, Arnd Bergmann wrote:
> That should not really be a concern, you only waste a little bit of
> the vmalloc space that you gained recently when ioremap was changed.
> Nothing should ever be able to get to those pointers other than by
> calling ioremap, so it doesn't hurt to have them mapped, except for
> the very unlikely scenario that you get a wild pointer dereference
> in the kernel that would otherwise result in an oops.

Ok. I will create two 16M mappings for now:

PHYSICAL			VIRTUAL
0xD0000000 - 0xD1000000		0xFD000000
0xFC000000 - 0xFD000000		0xFC000000


-- 
viresh
