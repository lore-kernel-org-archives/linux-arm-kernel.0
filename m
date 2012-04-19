From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 19 Apr 2012 14:46:58 +0530
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <201204190857.19770.arnd@arndb.de>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <CAJOA=zNPKrSSL5wjNBwL9qie5sGv9j=k3rSAmsjbK-6jfJwbgQ@mail.gmail.com>
 <CAJOA=zO4E0YJ0OU9n-abbNd+0VXQGsFi5Tnu5y=riHSgqk=xMw@mail.gmail.com>
 <201204190857.19770.arnd@arndb.de>
Message-ID: <4F8FD80A.1020901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2012 2:27 PM, Arnd Bergmann wrote:
> My preference would be to have the whole series go through your tree
> and move the implementation of the spear clock code to drivers/clk
> in the process. This will reduce interdependencies between the spear
> clock branch and other branches that have spear patches.

Atleast for now, SPEAr clock patches have dependency on earlier SPEAr patches
for which i have already sent you pull request.

So, this time atleast, these may go through your tree only.

You are talking about moving all clk files to drivers/clk or part of them
(plat/clk-*.c or mach/clock.c)

Also, i don't know what's the best way, but arch/arm/*spear* looks to be the
better place for SPEAr clock stuff. As it shares lot of registers/macros
with non-clock stuff. If we keep them in drivers/clk we have to include
<mach/...> files.

-- 
viresh
